type EnvVar = 'DATABASE_URL'

declare global {
  namespace NodeJS {
    interface ProcessEnv extends Record<EnvVar, string> {}
  }
}

export {}
