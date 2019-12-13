import { InputType, Field } from 'type-graphql'

@InputType()
export class RoutineInput {
  @Field()
  name: string
}
