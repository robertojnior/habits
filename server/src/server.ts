import Fastify from 'fastify'
import cors from '@fastify/cors'

import { routes } from './routes/router'

const app = Fastify({ logger: true })

app.register(cors, { origin: true })
app.register(routes)

app.listen({ port: 3000 })
