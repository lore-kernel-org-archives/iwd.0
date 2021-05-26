Content-Type: multipart/mixed; boundary="===============9198264675422939490=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/7] ip-pool: Track IPv4 addresses in use
Date: Wed, 26 May 2021 18:33:20 -0500
Message-ID: <6c921dd4-e993-0372-84fc-13c7328bbb30@gmail.com>
In-Reply-To: <CAOq732J2bNd5+BXfzpS3nfEJEJ9gdTVDztDvuDtYu9Ph7jzSTQ@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9198264675422939490==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 5/26/21 6:26 PM, Andrew Zaborowski wrote:
> On Thu, 27 May 2021 at 00:55, Denis Kenzior <denkenz@gmail.com> wrote:
>> On 5/26/21 5:36 PM, Andrew Zaborowski wrote:
>>> On Wed, 26 May 2021 at 23:56, Denis Kenzior <denkenz@gmail.com> wrote:
>>>>> Again, convenience, readability, better fit for the use case.  But
>>>>
>>>> readability? Yeah I don't buy that one ;)
>>>
>>> If you can write
>>>     ret_val =3D ip_pool_select_addr4(...);
>>>
>>>     do_some_maths(ret_val->addr)
>>>
>>
>> What maths are you performing and why?
> =

> Outside of ip_pool_select_addr4() itself (which will suffer internally
> too), there's some broadcast_from_ip() for example.

Just leave that.  Your argument of 'l_rtnl_address doesn't store the ifinde=
x' is =

fair.  I would have solved this differently, but in the end implementation =

details are just that.

What I care about is the API, get that right and you can fix the rest later.

> =

> But fair enough that should go away if we switch to
> l_rtnl_ifaddr_add() (But again this is a change out of the scope of

That is what I thought.

> this patchset that I've been rewriting since before the big ap.h
> change to use an l_settings and other unrelated changes)

And I get that.  I feel your pain.  But then, we're adding a new module and=
 I do =

want the APIs to be at least somewhat sorted from the very beginning.

Regards,
-Denis
--===============9198264675422939490==--

