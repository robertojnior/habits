import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

async function main() {
  await Promise.all([
    prisma.dailyRecord.deleteMany(),
    prisma.recurrence.deleteMany()
  ])

  await prisma.habit.deleteMany()

  await Promise.all([
    prisma.habit.create({
      data: {
        description: 'Walk the Dog',
        recurrences: {
          create: [{ week_day: 5 }, { week_day: 6 }]
        }
      }
    }),

    prisma.habit.create({
      data: {
        description: 'Go to the Gym',
        recurrences: {
          create: [
            { week_day: 1 },
            { week_day: 2 },
            { week_day: 3 },
            { week_day: 4 },
            { week_day: 5 },
            { week_day: 6 }
          ]
        },
        dailyRecords: {
          create: [{ week_day: 1 }, { week_day: 2 }]
        }
      }
    }),

    prisma.habit.create({
      data: {
        description: 'Drink Water',
        recurrences: {
          create: [
            { week_day: 1 },
            { week_day: 2 },
            { week_day: 3 },
            { week_day: 4 },
            { week_day: 5 },
            { week_day: 6 }
          ]
        },
        dailyRecords: {
          create: [{ week_day: 1 }, { week_day: 2 }]
        }
      }
    })
  ])
}

main()
  .then(async () => {
    await prisma.$disconnect()
  })
  .catch(async (e) => {
    console.error(e)

    await prisma.$disconnect()

    process.exit(1)
  })
