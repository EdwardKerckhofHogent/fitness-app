import { InputType, Field } from 'type-graphql'

@InputType()
export class SetInput {
  @Field({ nullable: true })
  id?: number

  @Field()
  kg: number

  @Field()
  reps: number
}
