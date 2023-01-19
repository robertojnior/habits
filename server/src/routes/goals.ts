import type { FastifyInstance } from 'fastify'

import dayjs from 'dayjs'
import { z } from 'zod'

import { prisma } from '../db/prisma'

export async function goals(app: FastifyInstance) {
  app.get('/', async (request, reply) => {
    const queryParamsSchema = z.object({
      date: z.coerce.date()
    })

    const { date } = queryParamsSchema.parse(request.query)

    const endOfTheDay = dayjs(date).endOf('day').toDate()
    const week_day = dayjs(date).get('day') + 1

    const goals = await prisma.goal.findMany({
      where: {
        created_at: {
          lte: endOfTheDay
        },
        recurrences: {
          some: {
            week_day
          }
        }
      },
      include: {
        dailyRecords: {
          where: {
            week_day
          }
        }
      }
    })

    return reply.header('X-Total-Count', goals.length).send(goals)
  })

  app.post('/', async (request, reply) => {
    const requestBodySchema = z.object({
      description: z.string(),
      recurrences: z.array(z.number().min(0).max(6))
    })

    const { description, recurrences } = requestBodySchema.parse(request.body)

    const goal = await prisma.goal.create({
      data: {
        description,
        recurrences: { create: recurrences.map((week_day) => ({ week_day })) }
      }
    })

    return reply.status(201).send(goal)
  })
}
