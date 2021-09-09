Content-Type: multipart/mixed; boundary="===============3073807238053428213=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 1/6] hwsim: add MatchBytes/MatchBytesOffset rule
 properties
Date: Thu, 09 Sep 2021 17:01:50 -0500
Message-ID: <4a57d392-61a8-b4a5-fb13-7b38ef43b3ce@gmail.com>
In-Reply-To: <20210909220848.19376-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3073807238053428213==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/9/21 5:08 PM, James Prestwood wrote:
> If set, a rule will start matching 'MatchBytes' some number of bytes
> into the frame (MatchBytesOffset). This is useful since header
> information, addresses, and sequence numbers may be unpredictable
> between test runs.
> =

> To avoid unintended matches the Prefix property is left unchanged
> and will match starting at the beginning of the frame.
> ---
>   tools/hwsim.c | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 106 insertions(+)
> =


All applied, thanks.

Regards,
-Denis

--===============3073807238053428213==--

