import { ObjectType, Field } from 'type-graphql'
import { FieldError } from '../FieldError'
import { Exercise } from '../../entity/Exercise'

@ObjectType()
export class ExerciseResponse {
  @Field(() => Exercise, { nullable: true })
  exercise?: Exercise

  @Field(() => [Exercise], { nullable: true })
  exercises?: Exercise[]

  @Field(() => [FieldError], { nullable: true })
  errors?: FieldError[]
}
