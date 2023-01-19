import type { FastifyInstance } from 'fastify'

import { goals } from './goals'

export async function routes(app: FastifyInstance) {
  app.register(goals, { prefix: '/goals' })
}
