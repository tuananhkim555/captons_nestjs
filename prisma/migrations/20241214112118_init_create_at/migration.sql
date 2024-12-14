-- AlterTable
ALTER TABLE `Category` ALTER COLUMN `updatedAt` DROP DEFAULT;

-- AlterTable
ALTER TABLE `User` MODIFY `updatedAt` DATETIME(3) NULL;
