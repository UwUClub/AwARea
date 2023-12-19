import { HydratedDocument } from 'mongoose';
import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';

export type UserDocument = HydratedDocument<User>;

@Schema()
export class User {
    @Prop({ default: null })
    username: string | null;

    @Prop({ required: true })
    fullName: string;

    @Prop({ required: true })
    email: string;

    @Prop({ default: null })
    password: string | null;

    @Prop({ default: null })
    googleId: string | null;

    @Prop({ default: null })
    googleAccessToken: string | null;

    @Prop({ default: null })
    googleRefreshToken: string | null;
}

export const UserSchema = SchemaFactory.createForClass(User);
