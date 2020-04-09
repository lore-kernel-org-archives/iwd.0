Content-Type: multipart/mixed; boundary="===============2657853660997381014=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] client: apply format attribute to two functions
Date: Thu, 09 Apr 2020 15:30:26 +0000
Message-ID: <b849eb4b-f67d-7e6d-8d44-28c05e3a8e5a@gmail.com>
In-Reply-To: <CAKxU2N9mYrbrLuevvfd_0ixortm2QmzOinr1_hj5FYWV+=2peg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2657853660997381014==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rosen,

On 4/8/20 3:54 PM, Rosen Penev wrote:
> On Wed, Apr 8, 2020 at 7:36 AM Denis Kenzior <denkenz@gmail.com> wrote:
>>
>> Hi Rosen,
>>
>> On 4/7/20 10:32 PM, Rosen Penev wrote:
>>> Clang was able to find these extra ones.
>>> ---
>>>    client/agent.c   | 2 +-
>>>    client/display.h | 6 ++++--
>>>    2 files changed, 5 insertions(+), 3 deletions(-)
>>
>> Looks fine to me, but gcc now complains:
>>
>>     CC       client/display.o
>> client/display.c: In function =E2=80=98display_enable_cmd_prompt=E2=80=
=99:
>> client/display.c:537:10: error: zero-length gnu_printf format string
>> [-Werror=3Dformat-zero-length]
>>     537 |  display("");
> What does this do anyway?

According to Tim this was needed for some readline behavior.  Anyhow, I =

applied a patch from Tim that gets rid of this particular line.

I went ahead and applied your original patch.  Thanks!

Regards,
-Denis
--===============2657853660997381014==--

