-- CreateTable
CREATE TABLE "daily_records" (
    "id" BIGINT NOT NULL PRIMARY KEY,
    "goal_id" TEXT NOT NULL,
    "week_day" INTEGER NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "daily_records_goal_id_fkey" FOREIGN KEY ("goal_id") REFERENCES "goals" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "daily_records_week_day_goal_id_key" ON "daily_records"("week_day", "goal_id");
