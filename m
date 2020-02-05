Content-Type: multipart/mixed; boundary="===============0796595179390743948=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Interface not detected sometimes
Date: Wed, 05 Feb 2020 09:00:08 -0600
Message-ID: <b7c5f640-8fc1-0fa6-27d7-5668973ab613@gmail.com>
In-Reply-To: <20200205125839.2820.81119@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0796595179390743948==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Hector,

On 2/5/20 6:58 AM, hector(a)ikatu.com wrote:
> Hi Denis,
> =

> thanks again!
> =

>> Note that by default iwd will try and remove all interfaces and will
>> only create a single station interface by default (if the driver allows,
>> which yours doesn't).
> =

> This means I have to enable "UseDefaultInterface"? The documentation says=
: "Enable this behavior if your wireless card driver is buggy or does not a=
llow such an operation, [...]"

You could, but it isn't strictly necessary if you're invoking iwd with =

--interface / --nointerface on the command line.  Doing so has the =

implicit effect of falling back to 'UseDefaultInterface' behavior.

Regards,
-Denis
--===============0796595179390743948==--

