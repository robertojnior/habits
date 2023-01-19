import type { FastifyInstance } from 'fastify'

import { z } from 'zod'

import { prisma } from '../db/prisma'

export async function goals(app: FastifyInstance) {
  app.get('/', async (request, reply) => {
    const goals = await prisma.goal.findMany()

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
