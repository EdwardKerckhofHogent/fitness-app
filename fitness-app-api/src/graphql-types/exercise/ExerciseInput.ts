import { InputType, Field } from 'type-graphql'
import { SetInput } from '../set/SetInput'

@InputType()
export class ExerciseInput {
  @Field()
  name: string

  @Field(_ => [SetInput])
  sets: [SetInput]
}
