Content-Type: multipart/mixed; boundary="===============7358824847283366967=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Start iwd device in ap mode by default
Date: Mon, 12 Apr 2021 22:01:12 -0500
Message-ID: <76fa776b-6ec4-0543-ba96-72e66d6eae4f@gmail.com>
In-Reply-To: <20210413004007.2848.34560@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7358824847283366967==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Salahaldeen,

On 4/12/21 7:40 PM, salahaldeen.altous(a)leica-camera.com wrote:
> Hi Denis
> =

>> Hi Salahaldeen,
>>
>> On 4/12/21 5:11 PM, salahaldeen.altous(a)leica-camera.com wrote:
>>
>> Unfortunately this is not yet supported.  This is definitely something t=
hat is
>> needed, but nobody has gotten around to adding this functionality.  Patc=
hes are
>> always welcome of course.
> Thanks for your quick reply. I will try to add this feature.
> Any hint where to start?

Start by looking into src/manager.c.  This is what is responsible for creat=
ing =

interfaces on the wiphys managed by iwd.  See manager_create_interfaces().

Right now we create a station interface and an optional P2P device wdev, =

depending on hardware capability.  I suppose it would make sense to have th=
e =

following states as configurable inside main.conf:

- station + p2p (current default)
- ap only
- maybe station + ap?

Feel free to find us on IRC if you want to brainstorm live, or on the maili=
ng list.

Regards,
-Denis
--===============7358824847283366967==--

