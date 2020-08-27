Content-Type: multipart/mixed; boundary="===============7690172207491780898=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 02/11] eap: Re-send Identity Request on EAPoL-Start
Date: Thu, 27 Aug 2020 15:38:04 -0500
Message-ID: <2dcc54ae-5179-d289-12a1-c99604d70311@gmail.com>
In-Reply-To: <CAOq732J7_bJ9Kb-DuJbe-eyGcDiuGm-JAKRzbz3KeEoPZrGK0g@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7690172207491780898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 8/27/20 3:47 PM, Andrew Zaborowski wrote:
> On Thu, 27 Aug 2020 at 20:55, Denis Kenzior <denkenz@gmail.com> wrote:
>> On 8/27/20 1:14 PM, Andrew Zaborowski wrote:
>>> It looks like clients sometimes miss our unsolicited Identity Request
>>> and need a resend.
>>> ---
>>>    src/eap.c   | 12 ++++++++++--
>>>    src/eapol.c | 12 ++++++++----
>>>    2 files changed, 18 insertions(+), 6 deletions(-)
>>>
>>
>> Applied.
>>
>> By the way, there are several implementations (Apple AirPort for example=
) that
>> do not start WSC until an EAPoL-Start is sent.  I don't recall that EAPo=
L-Start
>> behavior was specified in WSC 1.0.  I know that one of my routers that u=
ses WSC
>> 2.0 doesn't do this and sends a RequestIdentity right away.  So that mig=
ht
>> explain what you're seeing here.
> =

> So I intended to mention this separately but the spec recommends that
> we send the EAP Identity request automatically if the enrollee is WSC
> 2.0 and it prohibits us doing this if it's WSC 1.0.  I think there's
> probably no harm trying it until we see it throws off some device.

Okay.  So if the spec recommends this, it probably is intentional.  May be =
a =

good idea to follow its recommendation.  Do you recall where this is stated?

> =

> In my case an Android device replied to my initial Identity Request in
> three attempts, but on one occasion it apparently missed the request,
> sent the EAPoL-Start after a timeout and waited for a new Identity
> Request.
> =


Yeah, iwd (and I think wpa_s as well) starts a timer and sends an EAPoL-Sta=
rt if =

they don't receive the Request-Identity after some time.  But that doesn't =
mean =

others do.

Regards,
-Denis
--===============7690172207491780898==--

