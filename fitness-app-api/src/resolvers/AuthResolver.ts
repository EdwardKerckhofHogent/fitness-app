import { Resolver, Query } from 'type-graphql'

@Resolver()
export class AuthResolver {
  @Query(_ => String)
  async rootQuery(): Promise<String> {
    return 'Hello!'
  }
}
