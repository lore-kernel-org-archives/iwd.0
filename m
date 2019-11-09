Content-Type: multipart/mixed; boundary="===============5171632786908334805=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] scan: Separate cck rates attr creation into logical
 block
Date: Fri, 08 Nov 2019 21:46:20 -0600
Message-ID: <067a98bc-bdf1-41f5-d1f0-8ccc2b7477f8@gmail.com>
In-Reply-To: <19166F1D-20C3-4EDE-B1C3-D8F20CE42C07@holtmann.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5171632786908334805==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 11/8/19 9:42 PM, Marcel Holtmann wrote:
> =

> =

>> On Nov 9, 2019, at 04:33, Denis Kenzior <denkenz@gmail.com> wrote:
>>
>> Hi Marcel,
>>
>>> ok then, fair point. Can we somehow improve these cases with a comment =
to ease reading and understanding the code.
>>
>> So something like:
>>
>> +                *
>> +                * wiphy should have parsed the supported rates from the
>> +                * kernel / driver.  If not, warn and give up
>>
>> Or do you have something else in mind?
> =

> In addition I would also do
> =

> 	*
> 	* Keep full statement in L_WARN_ON to include more context when
> 	* the warning is triggered.
> =

> Just as a reminder for later days on why this is done. I am pretty sure o=
therwise I am going to stumble over it again and ask the same question.
> =


Right.  We do have a dozen or so of these now and I think the use of =

L_WARN will only keep growing.  Perhaps we should add another section to =

doc/coding-style.txt instead?  Formalize / encourage this as an optional =

best practice going forward.

Regards,
-Denis
--===============5171632786908334805==--

