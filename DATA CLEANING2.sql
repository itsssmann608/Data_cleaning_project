-- data cleaning2 

-- now when we are data cleaning we usually follow a few steps
-- 1. check for duplicates and remove any
-- 2. standardize data and fix errors
-- 3. Look at null values and see what 
-- 4. remove any columns and rows that are not necessary - few ways



-- 1. Remove Duplicates

# First let's check for duplicates


SELECT *
FROM layoffs_staging3;

DELETE FROM layoffs_staging3
WHERE row_num >= 2;

SELECT *
FROM layoffs_staging3;


-- standardizinng data


SELECT DISTINCT industry
FROM layoffs_staging3;

UPDATE industry
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT country
FROM layoffs_staging3
ORDER BY 1;

UPDATE layoffs_staging3
SET country = TRIM(TRAILING '.' FROM country);

SELECT `date`
FROM layoffs_staging3;

UPDATE layoffs_staging3
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging3
MODIFY COLUMN `date` DATE;

-- null

SELECT * 
FROM layoffs_staging3
WHERE percentage_laid_off IS NULL
AND total_laid_off IS NULL;

UPDATE layoffs_staging3
SET industry = NULL
WHERE industry = '';

SELECT *
FROM layoffs_staging3
WHERE industry IS NULL
OR industry = '';

SELECT *
FROM layoffs_staging3
WHERE company LIKE 'Bally%';

SELECT  t1.industry, t2.industry
FROM layoffs_staging3 t1
JOIN layoffs_staging3  t2
	ON t1.company = t2.company
    AND t1.location = t2.location
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry is NOT NULL;

UPDATE layoffs_staging3 t1
JOIN layoffs_staging3 t2
	ON t1.company= t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL 
AND t2.industry is NOT NULL;

SELECT *
FROM layoffs_staging3;

SELECT * 
FROM layoffs_staging3
WHERE percentage_laid_off IS NULL
AND total_laid_off IS NULL;

DELETE
FROM layoffs_staging3
WHERE percentage_laid_off IS NULL
AND total_laid_off IS NULL;

SELECT *
FROM layoffs_staging3;

ALTER TABLE layoffs_staging3
DROP COLUMN row_num;