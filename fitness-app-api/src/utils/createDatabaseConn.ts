import { getConnectionOptions, createConnection } from 'typeorm'

export const createDatabseConn = async () => {
  const connectionOptions = await getConnectionOptions(process.env.NODE_ENV)
  return process.env.NODE_ENV === 'production'
    ? createConnection({
        ...connectionOptions,
        name: 'default'
      } as any)
    : createConnection({ ...connectionOptions, name: 'default' })
}
