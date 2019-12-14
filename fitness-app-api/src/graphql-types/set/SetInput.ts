import { InputType, Field } from 'type-graphql'

@InputType()
export class SetInput {
  @Field()
  kg: number

  @Field()
  reps: number

  @Field()
  exerciseId: number
}
