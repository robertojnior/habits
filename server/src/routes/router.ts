import type { FastifyInstance } from 'fastify'

import { habits } from './habits'
import { dailyRecords } from './daily_records'

export async function routes(app: FastifyInstance) {
  app.register(habits, { prefix: '/habits' })
  app.register(dailyRecords)
}
