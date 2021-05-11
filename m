Content-Type: multipart/mixed; boundary="===============0166494881111183519=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 04/11] ap: Add subnet address selection logic
Date: Tue, 11 May 2021 17:20:11 -0500
Message-ID: <2a998b7b-408f-917f-f70e-5e3bb12427a9@gmail.com>
In-Reply-To: <CAOq732+uYG44riSqnxBprt0YsLXeFHY4aJ4KR8JV=buaUj+UCQ@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0166494881111183519==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>> I would rather we made this into a self contained module that pays atten=
tion to
>> RTNL and tracks any addresses added / removed.  That way the caller isn'=
t forced
>> into performing an RTNL dump first...
> =

> That is something I considered too but think about how many RTNL
> events and process wakeups we're generating this way compared to how
> often this data is actually used in a typical IWD session... do you
> still think it's a good idea?

Well, iwd already gets woken up by the RTNL events just by virtue of having=
 rtnl =

socket open.  We can install bpf filters for this, I suppose, but I wouldn'=
t =

want to try and implement one...  So I don't think this is a concern.

> =

> Also note we wouldn't be saving any code because the RTNL dump is
> still needed at the module init, it's only moved to a different file.

Sure, but then we can dump only once and listen to events after that.  Eith=
er =

way, it would simplify ap.c code quite a bit.

Regards,
-Denis
--===============0166494881111183519==--

