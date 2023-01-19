/*
  Warnings:

  - You are about to drop the `goals` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the column `goal_id` on the `recurrences` table. All the data in the column will be lost.
  - You are about to drop the column `goal_id` on the `daily_records` table. All the data in the column will be lost.
  - Added the required column `habit_id` to the `recurrences` table without a default value. This is not possible if the table is not empty.
  - Added the required column `habit_id` to the `daily_records` table without a default value. This is not possible if the table is not empty.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "goals";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "habits" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "description" TEXT NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_recurrences" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "habit_id" TEXT NOT NULL,
    "week_day" INTEGER NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "recurrences_habit_id_fkey" FOREIGN KEY ("habit_id") REFERENCES "habits" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_recurrences" ("created_at", "id", "week_day") SELECT "created_at", "id", "week_day" FROM "recurrences";
DROP TABLE "recurrences";
ALTER TABLE "new_recurrences" RENAME TO "recurrences";
CREATE UNIQUE INDEX "recurrences_week_day_habit_id_key" ON "recurrences"("week_day", "habit_id");
CREATE TABLE "new_daily_records" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "habit_id" TEXT NOT NULL,
    "week_day" INTEGER NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "daily_records_habit_id_fkey" FOREIGN KEY ("habit_id") REFERENCES "habits" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_daily_records" ("created_at", "id", "week_day") SELECT "created_at", "id", "week_day" FROM "daily_records";
DROP TABLE "daily_records";
ALTER TABLE "new_daily_records" RENAME TO "daily_records";
CREATE UNIQUE INDEX "daily_records_week_day_habit_id_key" ON "daily_records"("week_day", "habit_id");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
