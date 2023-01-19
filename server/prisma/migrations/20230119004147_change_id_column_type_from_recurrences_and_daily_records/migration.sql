/*
  Warnings:

  - The primary key for the `recurrences` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `recurrences` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Int`.
  - The primary key for the `daily_records` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `daily_records` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Int`.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_recurrences" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "goal_id" TEXT NOT NULL,
    "week_day" INTEGER NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "recurrences_goal_id_fkey" FOREIGN KEY ("goal_id") REFERENCES "goals" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_recurrences" ("created_at", "goal_id", "id", "week_day") SELECT "created_at", "goal_id", "id", "week_day" FROM "recurrences";
DROP TABLE "recurrences";
ALTER TABLE "new_recurrences" RENAME TO "recurrences";
CREATE UNIQUE INDEX "recurrences_week_day_goal_id_key" ON "recurrences"("week_day", "goal_id");
CREATE TABLE "new_daily_records" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "goal_id" TEXT NOT NULL,
    "week_day" INTEGER NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "daily_records_goal_id_fkey" FOREIGN KEY ("goal_id") REFERENCES "goals" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_daily_records" ("created_at", "goal_id", "id", "week_day") SELECT "created_at", "goal_id", "id", "week_day" FROM "daily_records";
DROP TABLE "daily_records";
ALTER TABLE "new_daily_records" RENAME TO "daily_records";
CREATE UNIQUE INDEX "daily_records_week_day_goal_id_key" ON "daily_records"("week_day", "goal_id");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
