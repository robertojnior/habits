import type { FastifyInstance } from 'fastify'

import { goals } from './goals'

export async function routes(fastify: FastifyInstance) {
  fastify.register(goals, { prefix: '/goals' })
}
