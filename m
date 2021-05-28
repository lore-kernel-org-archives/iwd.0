Content-Type: multipart/mixed; boundary="===============1152815835949809695=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: Re: [PATCH 1/3] network: sync known network frequency on BSS update
Date: Fri, 28 May 2021 07:32:53 +0000
Message-ID: <b89215c0-e4f6-bcbf-f1b0-a82dcdf6668a@bang-olufsen.dk>
In-Reply-To: <a6f0e6cf-4b4a-c38e-6024-962c02c68930@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1152815835949809695==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 5/27/21 8:57 PM, Denis Kenzior wrote:
> Hi Alvin,
> =

> On 5/27/21 9:22 AM, Alvin =C5=A0ipraga wrote:
>> From: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
>>
>> When a scan_bss is updated in the BSS list of a known network, it may be
>> on a new frequency. Sync the known frequencies list accordingly.
>> ---
>> =C2=A0 src/network.c | 6 ++++++
>> =C2=A0 1 file changed, 6 insertions(+)
>>
> =

> All applied.=C2=A0 I did have to massage the formatting in patch 2 to fit =

> into 80 columns.

Thanks. And sorry about the formatting...

I think it would be worth adding a .clang-format file to the project - =

what do you think? As a starting point, the kernel's .clang-format seems =

pretty close already. The main difference seems to be that it uses =

spaces after tabs to align parameters across multiple lines. I tried =

unsuccessfully to persuade it not to use any spaces for alignment, but =

I'm no expert.

> =

> Regards,
> -Denis

--===============1152815835949809695==--

