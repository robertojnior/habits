import type { FastifyInstance } from 'fastify'

import { prisma } from '../db/prisma'

export async function goals(app: FastifyInstance) {
  app.get('/', async (request, reply) => {
    const goals = await prisma.goal.findMany()

    return reply.header('X-Total-Count', goals.length).send(goals)
  })
}
