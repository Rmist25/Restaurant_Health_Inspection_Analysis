-- ========================================
-- 01. DATA PREPARATION
-- ========================================

-- Inspect the raw data
SELECT * FROM inspection_results;

-- Handle missing values
UPDATE inspection_results
SET cuisine_description = 'Not Specified'
WHERE cuisine_description IS NULL;

UPDATE inspection_results
SET grade = 'Inspection pending'
WHERE grade IS NULL OR grade = '';

UPDATE inspection_results
SET inspection_type = 'Inspection pending'
WHERE inspection_type IS NULL OR inspection_type = '';

UPDATE inspection_results
SET boro = 'Not Specified'
WHERE boro = '0' OR boro IS NULL;


-- View distinct cuisine values
SELECT DISTINCT cuisine_description
FROM inspection_results
ORDER BY cuisine_description;

-- Standardizing Cuisine Descriptions

UPDATE inspection_results
SET cuisine_description = CASE
    -- Asian / Oriental cuisines
    WHEN cuisine_description IN (
        'Asian/Asian Fusion', 'Chinese', 'Chinese/Cuban', 'Chinese/Japanese',
        'Filipino', 'Indian', 'Indonesian', 'Japanese', 'Korean', 
        'Pakistani', 'Southeast Asian', 'Thai', 'Bangladeshi'
    ) THEN 'Asian'

    -- American & related
    WHEN cuisine_description IN (
        'American', 'New American', 'Californian', 'Barbecue', 'Hamburgers',
        'Hotdogs', 'Hotdogs/Pretzels', 'Soul Food', 'Steakhouse'
    ) THEN 'American'

    -- European cuisines
    WHEN cuisine_description IN (
        'English', 'French', 'New French', 'Italian', 'German', 'Greek', 'Irish',
        'Polish', 'Portuguese', 'Russian', 'Scandinavian', 'Spanish', 'Basque', 'Armenian', 'Czech'
    ) THEN 'European'

    -- Mediterranean / Middle Eastern
    WHEN cuisine_description IN (
        'Mediterranean', 'Middle Eastern', 'Lebanese', 'Turkish', 'Moroccan', 
        'Egyptian', 'Jewish/Kosher'
    ) THEN 'Mediterranean/Middle Eastern'

    -- Latin American / Caribbean
    WHEN cuisine_description IN (
        'Latin American', 'Mexican', 'Tex-Mex', 'Caribbean', 'Brazilian', 
        'Peruvian', 'Chilean', 'Creole', 'Creole/Cajun', 'Cajun'
    ) THEN 'Latin/Caribbean'

    -- African
    WHEN cuisine_description IN ('African', 'Ethiopian') THEN 'African'

    -- Australian / Oceanic
    WHEN cuisine_description IN ('Australian', 'Hawaiian') THEN 'Oceanic'

    -- Vegetarian / Vegan
    WHEN cuisine_description IN ('Vegetarian', 'Vegan', 'Salads') THEN 'Vegetarian/Vegan'

    -- Cafe / Bakery / Beverage
    WHEN cuisine_description IN (
        'Bakery Products/Desserts', 'Frozen Desserts', 'Donuts', 'Pancakes/Waffles',
        'Bagels/Pretzels', 'Coffee/Tea', 'Juice, Smoothies, Fruit Salads',
        'Bottled Beverages', 'Nuts/Confectionary', 'Fruits/Vegetables'
    ) THEN 'Cafe/Bakery'

    -- Sandwich / Light meals
    WHEN cuisine_description IN (
        'Sandwiches', 'Sandwiches/Salads/Mixed Buffet', 'Soups',
        'Soups/Salads/Sandwiches', 'Chicken'
    ) THEN 'Sandwiches & Light Meals'

    -- Fusion / Contemporary / Other
    WHEN cuisine_description IN ('Fusion', 'Haute Cuisine', 'Continental', 'Tapas', 'Southwestern') THEN 'Fusion/Contemporary'

    -- Not listed or unspecified
    WHEN cuisine_description IN ('Other', 'Not Listed/Not Applicable', 'Not Specified') THEN 'Other/Not Specified'

    ELSE cuisine_description
END;

-- Convert date columns to proper datetime format
UPDATE inspection_results
SET 
    inspection_date = TRY_CAST(inspection_date AS DATETIME),
    grade_date = TRY_CAST(grade_date AS DATETIME);
