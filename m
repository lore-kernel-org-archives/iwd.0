Content-Type: multipart/mixed; boundary="===============2856911845471052585=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH] scan: don't send the same scan request twice
Date: Sun, 31 May 2020 00:26:51 +0200
Message-ID: <CAOq732LjDvnJ-PpLEYOrJ=Un43N0JHOE_n2Zj_Amrvob2F=FwQ@mail.gmail.com>
In-Reply-To: <20200529135451.21290-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2856911845471052585==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alvin,
(resending this to the list)

On Fri, 29 May 2020 at 15:57, Alvin =C5=A0ipraga <alsi@bang-olufsen.dk> w=
rote:
>
> If start_scan_next_request() is called while a scan request
> (NL80211_CMD_GET_SCAN) is still running, the same scan request will be
> sent again by mistake. Add a check in the function to avoid sending a
> request if one is already in progress.

Do you know if start_scan_next_request() was called from scan_resume
in your case?  In all other callers we can be sure start_cmd_id is
already 0, so scan_resume may need to have these checks added instead.
I think it should check that !sc->start_cmd_id && !sc->triggered &&
!sc->get_scan_cmd_id because the scan_resume() call can come in during
any of those phases.

BTW you mention NL80211_CMD_GET_SCAN above, I think you meant
NL80211_CMD_TRIGGER_SCAN.

I also wonder if scan_common() should check sc->suspended like
start_scan_next_request() does.

Best regards
--===============2856911845471052585==--

