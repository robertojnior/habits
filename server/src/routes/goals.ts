import type { FastifyInstance } from 'fastify'

import { prisma } from '../db/prisma'

export async function goals(fastify: FastifyInstance) {
  fastify.get('/', async (request, reply) => {
    const goals = await prisma.goal.findMany()

    return reply.header('X-Total-Count', goals.length).send(goals)
  })
}
