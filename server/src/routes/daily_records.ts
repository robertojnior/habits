import type { FastifyInstance } from 'fastify'

import { z } from 'zod'

import { prisma } from '../db/prisma'

export async function dailyRecords(app: FastifyInstance) {
  app.post('/habits/:habit_id/daily_records', async (request, reply) => {
    const requestParamsSchema = z.object({
      habit_id: z.string().uuid()
    })

    const { habit_id } = requestParamsSchema.parse(request.params)

    const requestBodySchema = z.object({
      week_day: z.number()
    })

    const { week_day } = requestBodySchema.parse(request.body)

    const dailyRecord = await prisma.dailyRecord.create({
      data: {
        habit_id,
        week_day
      }
    })

    return reply.status(201).send(dailyRecord)
  })

  app.delete('/daily_records/:id', async (request, reply) => {
    const requestParamsSchema = z.object({
      id: z.number()
    })

    const { id } = requestParamsSchema.parse(request.params)

    await prisma.dailyRecord.delete({
      where: {
        id
      }
    })

    return reply.status(204).send()
  })
}
