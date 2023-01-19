import type { FastifyInstance } from 'fastify'

import { habits } from './habits'

export async function routes(app: FastifyInstance) {
  app.register(habits, { prefix: '/habits' })
}
