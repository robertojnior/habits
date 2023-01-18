-- CreateTable
CREATE TABLE "recurrences" (
    "id" BIGINT NOT NULL PRIMARY KEY,
    "goal_id" TEXT NOT NULL,
    "week_day" INTEGER NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "recurrences_goal_id_fkey" FOREIGN KEY ("goal_id") REFERENCES "goals" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "recurrences_week_day_goal_id_key" ON "recurrences"("week_day", "goal_id");
