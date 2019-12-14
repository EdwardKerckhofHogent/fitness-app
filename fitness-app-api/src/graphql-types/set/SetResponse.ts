import { ObjectType, Field } from 'type-graphql'

import { FieldError } from '../FieldError'
import { ExerciseSet } from '../../entity/ExerciseSet'

@ObjectType()
export class SetResponse {
  @Field(() => ExerciseSet, { nullable: true })
  set?: ExerciseSet

  @Field(() => [ExerciseSet], { nullable: true })
  sets?: ExerciseSet[]

  @Field(() => [FieldError], { nullable: true })
  errors?: FieldError[]
}
