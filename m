Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A42312F5B3
	for <iwd@lists.linux.dev>; Tue, 16 Apr 2024 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277033; cv=none; b=qAwFRznoK1wdPJ1InNhtunSqBZHtfusxDh+MFFJyrwDmIJ2VfywZ8VOEBNUDjl9uonrTLdzMdQxp61Jpw05TlEmRkDdqBmbBYg5dUNoJwwwSk1dewYFPSkXv/rLv+xkRg+bVpEawc12KfpJvt2GURUM/MpOoW5LcmE9OMg29NZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277033; c=relaxed/simple;
	bh=i5MbpijsFhBKkp5d69/egEMVDManASdP6sA4avlOFRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M2+vP6Q4qpTLHwKIur8TonhHulD4/QujC0fN7WNVEL+z9yrtReC2g7YUtA+rD2+c4m0WS3PL8KTsO1XZ0hJ+Xf+PFyA8ycFj4O3QmTsVTqosId4khg1tXyJJtCUBv5Qxs+nqB5oEdA0CaozTyrfKT9tPAzvUinQNIfwGI9A2UWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6KUOcws; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6KUOcws"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e5715a9ebdso35699675ad.2
        for <iwd@lists.linux.dev>; Tue, 16 Apr 2024 07:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713277031; x=1713881831; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c9L+4gNDV2jN4BQAePezXA3JbCS+k5lQqGBehxck0fI=;
        b=I6KUOcwsH4gnAocjGq/M5XS5Us6Kdvq16Xc4hIAVaWQey/gndOHy5ykiyt3et9E0XE
         WE70rHE+Ra7ZNSCWJisptnAQ7mog9Kd8+pvybRTc0LvQ4vgl1RF8k27BCdb2TIwQNXyb
         LAzAgkkUEf8PkuRWhBFkkxSmpoj+HM6OQDT8pav3p0BCGvtRgzH2KPrYrHx3Ta1Qzafi
         ET2Zsm+lcEvyFgEXieUqXUdGBHPgN+XeGcQhnwXI12X2wD+ptPL1bIxVcl3RGtVimK+K
         JTRoJnqhLjVD9f3Fs4Hp9TYbrZ8eXPtvNGcqUgeMsMNanOK7bXmoidjnGQ05kU+qzcxU
         ByXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713277031; x=1713881831;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c9L+4gNDV2jN4BQAePezXA3JbCS+k5lQqGBehxck0fI=;
        b=iOXwR05Ss3CJZW41yu7blxqnxiRW0a8x+w43GS1mSJ42G5FS5SimJCMwLtrRA26e//
         71OLEt1TuBhPdWgyH4Jeahb3rm2+7mvVPltxo19p+ic3x9JHP8+sKtHok49GuE13LfJz
         x8jsV48bem92OORcJdThUNqVsSlg0xSUidKatRdZ4LQmAPawEyOT6pyqRseW7NoVrAvu
         nO6K3feG50HYhXP7+wBg7Kj6ONwVm04fOqtQX9Ym1ehsjmKoP1FDMADWNlpLluqmeuhj
         1Ep6YEHS3OwD4qkXm2gvnxBUQKlaqBWkpUieMVHRJcVAGuzVcn7uo3Ht/eM8iXM1NhVL
         73tA==
X-Forwarded-Encrypted: i=1; AJvYcCXxVDsN6G731JrDSjGkIeBgp34vdO00RmDr9qQ41XvIqtprSCqKLFLPb/K/sufpwb8rST2Q0H4ZcDSsSF/reISSHl30
X-Gm-Message-State: AOJu0YwmAx8OfLXCdR5uqau0DzhsjYAMiFP1MogpPJUQ9bY/pshh8Vmd
	kVQWyjdroWQR5gLeRQxusCKVDSBQwas8UqGlGsi9q8hVMECtpPagm+Ay3ZLSgDHBOXpKh8sAmlr
	c0rIyGBrvFRc+5lP8Z/9sadg2NWw=
X-Google-Smtp-Source: AGHT+IEXkl6fuETOxKFEuK0j3mNyN8MfCkqP4tcOKgVy6tmw6X9EWklaXiBRlzjizWEyQibXVA0wkzsq8tLghUi70ek=
X-Received: by 2002:a17:902:7687:b0:1e0:3084:6cb4 with SMTP id
 m7-20020a170902768700b001e030846cb4mr11092759pll.17.1713277031139; Tue, 16
 Apr 2024 07:17:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAG17S_OZt84p8HQ4E189+VTMssSrDBDXNzeMUT_hZb=jbuKE6Q@mail.gmail.com>
 <7978cd1a-8122-4b6b-9e38-b7d65a9c393e@gmail.com> <8c99082f-fa0d-4c9f-87ab-e49dc9e0f497@gmail.com>
 <558f87c3-7f6f-4c9b-9ff0-42f261f13ef3@gmail.com> <82b55e12-5f9b-4b31-b44f-18b8de4fce14@gmail.com>
In-Reply-To: <82b55e12-5f9b-4b31-b44f-18b8de4fce14@gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Tue, 16 Apr 2024 09:16:59 -0500
Message-ID: <CAG17S_PvKeP98kDwBEfAVJg7nRDH50HgsxYZ-YXD6wL6AnQN5A@mail.gmail.com>
Subject: Re: NT/VHT errors filling log
To: James Prestwood <prestwoj@gmail.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
Content-Type: multipart/mixed; boundary="000000000000d7ebac0616376494"

--000000000000d7ebac0616376494
Content-Type: multipart/alternative; boundary="000000000000d7ebaa0616376492"

--000000000000d7ebaa0616376492
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

James,

The messages have changed with the latest build.
Apr 16 05:24:30 kitchenrune iwd[1490859]: invalid HE capabilities for
ac:ec:85:ab:10:d4
Apr 16 05:53:31 kitchenrune iwd[1490859]: invalid HE capabilities for
d8:07:b6:8e:97:7b
Apr 16 05:58:23 kitchenrune iwd[1490859]: invalid HE capabilities for
d8:07:b6:8e:97:7b
Apr 16 06:22:23 kitchenrune iwd[1490859]: invalid HE capabilities for
d8:07:b6:8e:97:7b
Apr 16 06:53:26 kitchenrune iwd[1490859]: invalid HE capabilities for
d8:07:b6:8e:97:7b
Apr 16 07:23:39 kitchenrune iwd[1490859]: invalid HE capabilities for
d8:07:b6:8e:97:7b
Apr 16 07:55:07 kitchenrune iwd[1490859]: invalid HE capabilities for
d8:07:b6:8e:97:7b
Apr 16 07:55:07 kitchenrune iwd[1490859]: invalid HE capabilities for
ae:70:5d:05:9f:f2
Apr 16 07:58:34 kitchenrune iwd[1490859]: invalid HE capabilities for
d8:07:b6:8e:97:7b
Apr 16 08:25:08 kitchenrune iwd[1490859]: invalid HE capabilities for
d8:07:b6:8e:97:7b
Apr 16 08:25:08 kitchenrune iwd[1490859]: invalid HE capabilities for
1c:93:7c:73:36:92
Apr 16 08:25:08 kitchenrune iwd[1490859]: invalid HE capabilities for
06:93:7c:73:36:92

Periodic scanning info from today.

I use connman to manage the networks and we have a php script to scrape the
network information advertised by the SSIDs. The attached txt file may be
interesting to see what my RPi sees.

Keith



On Mon, Apr 15, 2024 at 1:57=E2=80=AFPM James Prestwood <prestwoj@gmail.com=
> wrote:
>
>
> On 4/15/24 11:50 AM, Denis Kenzior wrote:
> > Hi James,
> >
> > On 4/15/24 10:15, James Prestwood wrote:
> >> Hi Keith,
> >>
> >> On 4/15/24 4:24 AM, James Prestwood wrote:
> >>> Hi Keith,
> >>>
> >>> On 4/12/24 10:41 AM, KeithG wrote:
> >>>> Group,
> >>>>
> >>>> This is on a Pi5. this is with the 'current from git' build of iwd.
> >>>> iwd-git/now 2.17.r0.g468cecdb-1
> >>>> These are new errors which are showing up in the log and recur a lot=
:
> >>>> Apr 12 12:14:17 pi5 iwd[1537]: error parsing HT capabilities
> >>>> Apr 12 12:14:17 pi5 iwd[1537]: error parsing non-HT rates
> >>>> Apr 12 12:14:17 pi5 iwd[1537]: error parsing VHT capabilities
> >>>> Apr 12 12:14:17 pi5 iwd[1537]: error parsing HT capabilities
> >>>> Apr 12 12:14:17 pi5 iwd[1537]: error parsing non-HT rates
> >>>
> >>> I added these recently as well as a small modification to improve
> >>> fallback behavior for calculating the data rate. This isn't coming
> >>> from the driver, but the scan results. Apparently APs sending
> >>> invalid IEs is more widespread than I thought. I'll need to change
> >>> this to instead maybe a single warning, or maybe hidden behind an
> >>> env var.
> >>
> >> I sent some patches to the list which should help. You may still get
> >> a warning for HE capabilities though, if APs are advertising the
> >> malformed IE.
> >
> > Can we find out what is causing the errors?  Is it the low RSSI?
> >
> > I rather we added a L_WARN_ONCE or L_WARN_THROTTLED or something
> > instead of turning them off.
>
> Most likely low RSSI because I didn't handle -ENETUNREACH, so it treated
> it as an error rather than silently dropping down to the next capability.
>
> >
> > Regards,
> > -Denis

--000000000000d7ebaa0616376492
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"auto">James,</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">The messages have changed with the latest build.<div dir=
=3D"auto"><div dir=3D"auto">Apr 16 05:24:30 kitchenrune iwd[1490859]: inval=
id HE capabilities for ac:ec:85:ab:10:d4</div><div dir=3D"auto">Apr 16 05:5=
3:31 kitchenrune iwd[1490859]: invalid HE capabilities for d8:07:b6:8e:97:7=
b</div><div dir=3D"auto">Apr 16 05:58:23 kitchenrune iwd[1490859]: invalid =
HE capabilities for d8:07:b6:8e:97:7b</div><div dir=3D"auto">Apr 16 06:22:2=
3 kitchenrune iwd[1490859]: invalid HE capabilities for d8:07:b6:8e:97:7b</=
div><div dir=3D"auto">Apr 16 06:53:26 kitchenrune iwd[1490859]: invalid HE =
capabilities for d8:07:b6:8e:97:7b</div><div dir=3D"auto">Apr 16 07:23:39 k=
itchenrune iwd[1490859]: invalid HE capabilities for d8:07:b6:8e:97:7b</div=
><div dir=3D"auto">Apr 16 07:55:07 kitchenrune iwd[1490859]: invalid HE cap=
abilities for d8:07:b6:8e:97:7b</div><div dir=3D"auto">Apr 16 07:55:07 kitc=
henrune iwd[1490859]: invalid HE capabilities for ae:70:5d:05:9f:f2</div><d=
iv dir=3D"auto">Apr 16 07:58:34 kitchenrune iwd[1490859]: invalid HE capabi=
lities for d8:07:b6:8e:97:7b</div><div dir=3D"auto">Apr 16 08:25:08 kitchen=
rune iwd[1490859]: invalid HE capabilities for d8:07:b6:8e:97:7b</div><div =
dir=3D"auto">Apr 16 08:25:08 kitchenrune iwd[1490859]: invalid HE capabilit=
ies for 1c:93:7c:73:36:92</div><div dir=3D"auto">Apr 16 08:25:08 kitchenrun=
e iwd[1490859]: invalid HE capabilities for 06:93:7c:73:36:92</div><div dir=
=3D"auto"><br></div><div>Periodic scanning info from today.<br></div><div d=
ir=3D"auto"><br></div><div>I use connman to manage the networks and we have=
 a php script to scrape the network information advertised by the SSIDs. Th=
e attached txt file may be interesting to see what my RPi sees.<br></div><d=
iv><br></div><div>Keith<br></div></div><div dir=3D"auto"><br></div></div></=
div><br>
<br>
On Mon, Apr 15, 2024 at 1:57=E2=80=AFPM James Prestwood &lt;<a href=3D"mail=
to:prestwoj@gmail.com" rel=3D"noreferrer noreferrer" target=3D"_blank">pres=
twoj@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt; On 4/15/24 11:50 AM, Denis Kenzior wrote:<br>
&gt; &gt; Hi James,<br>
&gt; &gt;<br>
&gt; &gt; On 4/15/24 10:15, James Prestwood wrote:<br>
&gt; &gt;&gt; Hi Keith,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On 4/15/24 4:24 AM, James Prestwood wrote:<br>
&gt; &gt;&gt;&gt; Hi Keith,<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; On 4/12/24 10:41 AM, KeithG wrote:<br>
&gt; &gt;&gt;&gt;&gt; Group,<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; This is on a Pi5. this is with the &#39;current from =
git&#39; build of iwd.<br>
&gt; &gt;&gt;&gt;&gt; iwd-git/now 2.17.r0.g468cecdb-1<br>
&gt; &gt;&gt;&gt;&gt; These are new errors which are showing up in the log =
and recur a lot:<br>
&gt; &gt;&gt;&gt;&gt; Apr 12 12:14:17 pi5 iwd[1537]: error parsing HT capab=
ilities<br>
&gt; &gt;&gt;&gt;&gt; Apr 12 12:14:17 pi5 iwd[1537]: error parsing non-HT r=
ates<br>
&gt; &gt;&gt;&gt;&gt; Apr 12 12:14:17 pi5 iwd[1537]: error parsing VHT capa=
bilities<br>
&gt; &gt;&gt;&gt;&gt; Apr 12 12:14:17 pi5 iwd[1537]: error parsing HT capab=
ilities<br>
&gt; &gt;&gt;&gt;&gt; Apr 12 12:14:17 pi5 iwd[1537]: error parsing non-HT r=
ates<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; I added these recently as well as a small modification to=
 improve<br>
&gt; &gt;&gt;&gt; fallback behavior for calculating the data rate. This isn=
&#39;t coming<br>
&gt; &gt;&gt;&gt; from the driver, but the scan results. Apparently APs sen=
ding<br>
&gt; &gt;&gt;&gt; invalid IEs is more widespread than I thought. I&#39;ll n=
eed to change<br>
&gt; &gt;&gt;&gt; this to instead maybe a single warning, or maybe hidden b=
ehind an<br>
&gt; &gt;&gt;&gt; env var.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I sent some patches to the list which should help. You may st=
ill get<br>
&gt; &gt;&gt; a warning for HE capabilities though, if APs are advertising =
the<br>
&gt; &gt;&gt; malformed IE.<br>
&gt; &gt;<br>
&gt; &gt; Can we find out what is causing the errors?=C2=A0 Is it the low R=
SSI?<br>
&gt; &gt;<br>
&gt; &gt; I rather we added a L_WARN_ONCE or L_WARN_THROTTLED or something<=
br>
&gt; &gt; instead of turning them off.<br>
&gt;<br>
&gt; Most likely low RSSI because I didn&#39;t handle -ENETUNREACH, so it t=
reated<br>
&gt; it as an error rather than silently dropping down to the next capabili=
ty.<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; Regards,<br>
&gt; &gt; -Denis<br>

--000000000000d7ebaa0616376492--
--000000000000d7ebac0616376494
Content-Type: text/plain; charset="US-ASCII"; name="networks.txt"
Content-Disposition: attachment; filename="networks.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lv2guiuv0>
X-Attachment-Id: f_lv2guiuv0

eyJkODNhZGRhNjg1NDhfNzM3MDY3MzUiOnsicHJpbWFyeURucyI6IjE5Mi4xNjguMi4yNTMiLCJz
ZWNvbmRhcnlEbnMiOiIiLCJzZWN1cml0eSI6IlBTSyIsInN0cmVuZ3RoIjoiODEiLCJzdHJlbmd0
aFN0YXJzIjoiICYjOTczMyAmIzk3MzMgJiM5NzMzICYjOTczMyAmIzk3MzMgJiM5NzMzICYjOTcz
MyAmIzk3MzMiLCJpcEFzc2lnbm1lbnQiOiJESENQIiwiaXB2Ni5tZXRob2QiOiJvZmYiLCJzc2lk
Ijoic3BnNSIsInNzaWRIZXgiOiI3MzcwNjczNSIsInN0YXR1cyI6IipBTyIsImNvbm5tYW5TdHJp
bmciOiJ3aWZpX2Q4M2FkZGE2ODU0OF83MzcwNjczNV9tYW5hZ2VkX3BzayIsIm1hY0FkZHJlc3Mi
OiJkODNhZGRhNjg1NDgiLCJ0ZWNobm9sb2d5Ijoid2lmaSIsIm5pYyI6IndsYW4wIiwiY29uZmln
dXJlZCI6dHJ1ZSwiYXV0b2Nvbm5lY3QiOnRydWUsIm9ubGluZSI6dHJ1ZSwicmVhZHkiOmZhbHNl
LCJpcFN0YXR1cyI6IlVQIiwiaXBJbmZvIjoiPEJST0FEQ0FTVCxNVUxUSUNBU1QsVVAsTE9XRVJf
VVA+IiwiaXB2NEFkZHJlc3MiOiIxOTIuMTY4LjIuMjAwIiwiaXB2NkFkZHJlc3MiOiIiLCJpcHY0
UmVzdCI6InNjb3BlIGdsb2JhbCBub3ByZWZpeHJvdXRlIHdsYW4wIHZhbGlkX2xmdCBmb3JldmVy
IHByZWZlcnJlZF9sZnQgZm9yZXZlciIsImlwdjZSZXN0IjoiIn0sCiJkODNhZGRhNjg1NDhfNDE1
NDU0NTc3NTQ5NmI0MTM1NDEiOnsicHJpbWFyeURucyI6IjE5Mi4xNjguMi4yNTMiLCJzZWNvbmRh
cnlEbnMiOiIiLCJzZWN1cml0eSI6IlBTSyIsInN0cmVuZ3RoIjoiNDYiLCJzdHJlbmd0aFN0YXJz
IjoiICYjOTczMyAmIzk3MzMgJiM5NzMzICYjOTczMyAmIzk3MzMiLCJkZWZhdWx0R2F0ZXdheSI6
IjE5Mi4xNjguMi4yNTQiLCJpcHY0TWFzayI6IjI1NS4yNTUuMjU1LjAiLCJpcHY2Lm1ldGhvZCI6
ImF1dG8iLCJpcHY2LnByaXZhY3kiOiJkaXNhYmxlZCIsInNzaWQiOiJBVFRXdUlrQTVBIiwic3Np
ZEhleCI6IjQxNTQ1NDU3NzU0OTZiNDEzNTQxIiwic3RhdHVzIjoiIiwiY29ubm1hblN0cmluZyI6
IndpZmlfZDgzYWRkYTY4NTQ4XzQxNTQ1NDU3NzU0OTZiNDEzNTQxX21hbmFnZWRfcHNrIiwibWFj
QWRkcmVzcyI6ImQ4M2FkZGE2ODU0OCIsInRlY2hub2xvZ3kiOiJ3aWZpIiwibmljIjoid2xhbjAi
LCJjb25maWd1cmVkIjpmYWxzZSwiYXV0b2Nvbm5lY3QiOmZhbHNlLCJvbmxpbmUiOmZhbHNlLCJy
ZWFkeSI6ZmFsc2V9LAoiZDgzYWRkYTY4NTQ4XzQ4NGY0ZDQ1MmQzNDQ1MzYzMiI6eyJwcmltYXJ5
RG5zIjoiMTkyLjE2OC4yLjI1MyIsInNlY29uZGFyeURucyI6IiIsInNlY3VyaXR5IjoiUFNLIiwi
c3RyZW5ndGgiOiI1MiIsInN0cmVuZ3RoU3RhcnMiOiIgJiM5NzMzICYjOTczMyAmIzk3MzMgJiM5
NzMzICYjOTczMyIsImRlZmF1bHRHYXRld2F5IjoiMTkyLjE2OC4yLjI1NCIsImlwdjRNYXNrIjoi
MjU1LjI1NS4yNTUuMCIsImlwdjYubWV0aG9kIjoiYXV0byIsImlwdjYucHJpdmFjeSI6ImRpc2Fi
bGVkIiwic3NpZCI6IkhPTUUtNEU2MiIsInNzaWRIZXgiOiI0ODRmNGQ0NTJkMzQ0NTM2MzIiLCJz
dGF0dXMiOiIiLCJjb25ubWFuU3RyaW5nIjoid2lmaV9kODNhZGRhNjg1NDhfNDg0ZjRkNDUyZDM0
NDUzNjMyX21hbmFnZWRfcHNrIiwibWFjQWRkcmVzcyI6ImQ4M2FkZGE2ODU0OCIsInRlY2hub2xv
Z3kiOiJ3aWZpIiwibmljIjoid2xhbjAiLCJjb25maWd1cmVkIjpmYWxzZSwiYXV0b2Nvbm5lY3Qi
OmZhbHNlLCJvbmxpbmUiOmZhbHNlLCJyZWFkeSI6ZmFsc2V9LAoiZDgzYWRkYTY4NTQ4XzQ0NjU2
ZDQyNmY3OTdhIjp7InByaW1hcnlEbnMiOiIxOTIuMTY4LjIuMjUzIiwic2Vjb25kYXJ5RG5zIjoi
Iiwic2VjdXJpdHkiOiJQU0siLCJzdHJlbmd0aCI6IjQ2Iiwic3RyZW5ndGhTdGFycyI6IiAmIzk3
MzMgJiM5NzMzICYjOTczMyAmIzk3MzMgJiM5NzMzIiwiZGVmYXVsdEdhdGV3YXkiOiIxOTIuMTY4
LjIuMjU0IiwiaXB2NE1hc2siOiIyNTUuMjU1LjI1NS4wIiwiaXB2Ni5tZXRob2QiOiJhdXRvIiwi
aXB2Ni5wcml2YWN5IjoiZGlzYWJsZWQiLCJzc2lkIjoiRGVtQm95eiIsInNzaWRIZXgiOiI0NDY1
NmQ0MjZmNzk3YSIsInN0YXR1cyI6IiIsImNvbm5tYW5TdHJpbmciOiJ3aWZpX2Q4M2FkZGE2ODU0
OF80NDY1NmQ0MjZmNzk3YV9tYW5hZ2VkX3BzayIsIm1hY0FkZHJlc3MiOiJkODNhZGRhNjg1NDgi
LCJ0ZWNobm9sb2d5Ijoid2lmaSIsIm5pYyI6IndsYW4wIiwiY29uZmlndXJlZCI6ZmFsc2UsImF1
dG9jb25uZWN0IjpmYWxzZSwib25saW5lIjpmYWxzZSwicmVhZHkiOmZhbHNlfSwKImQ4M2FkZGE2
ODU0OF80MzQxNTIiOnsicHJpbWFyeURucyI6IjE5Mi4xNjguMi4yNTMiLCJzZWNvbmRhcnlEbnMi
OiIiLCJzZWN1cml0eSI6IlBTSyIsInN0cmVuZ3RoIjoiNTIiLCJzdHJlbmd0aFN0YXJzIjoiICYj
OTczMyAmIzk3MzMgJiM5NzMzICYjOTczMyAmIzk3MzMiLCJkZWZhdWx0R2F0ZXdheSI6IjE5Mi4x
NjguMi4yNTQiLCJpcHY0TWFzayI6IjI1NS4yNTUuMjU1LjAiLCJpcHY2Lm1ldGhvZCI6ImF1dG8i
LCJpcHY2LnByaXZhY3kiOiJkaXNhYmxlZCIsInNzaWQiOiJDQVIiLCJzc2lkSGV4IjoiNDM0MTUy
Iiwic3RhdHVzIjoiIiwiY29ubm1hblN0cmluZyI6IndpZmlfZDgzYWRkYTY4NTQ4XzQzNDE1Ml9t
YW5hZ2VkX3BzayIsIm1hY0FkZHJlc3MiOiJkODNhZGRhNjg1NDgiLCJ0ZWNobm9sb2d5Ijoid2lm
aSIsIm5pYyI6IndsYW4wIiwiY29uZmlndXJlZCI6ZmFsc2UsImF1dG9jb25uZWN0IjpmYWxzZSwi
b25saW5lIjpmYWxzZSwicmVhZHkiOmZhbHNlfSwKImQ4M2FkZGE2ODU0OF82ZTY5NjM2ZjVmNzc2
OTY2NjkiOnsicHJpbWFyeURucyI6IjE5Mi4xNjguMi4yNTMiLCJzZWNvbmRhcnlEbnMiOiIiLCJz
ZWN1cml0eSI6IlBTSyIsInN0cmVuZ3RoIjozNSwic3RyZW5ndGhTdGFycyI6IiAmIzk3MzMgJiM5
NzMzICYjOTczMyAmIzk3MzMiLCJkZWZhdWx0R2F0ZXdheSI6IjE5Mi4xNjguMi4yNTQiLCJpcHY0
TWFzayI6IjI1NS4yNTUuMjU1LjAiLCJpcHY2Lm1ldGhvZCI6ImF1dG8iLCJpcHY2LnByaXZhY3ki
OiJkaXNhYmxlZCIsInNzaWQiOiJuaWNvX3dpZmkiLCJzc2lkSGV4IjoiNmU2OTYzNmY1Zjc3Njk2
NjY5Iiwic3RhdHVzIjoiIiwiY29ubm1hblN0cmluZyI6IndpZmlfZDgzYWRkYTY4NTQ4XzZlNjk2
MzZmNWY3NzY5NjY2OV9tYW5hZ2VkX3BzayIsIm1hY0FkZHJlc3MiOiJkODNhZGRhNjg1NDgiLCJ0
ZWNobm9sb2d5Ijoid2lmaSIsIm5pYyI6IndsYW4wIiwiY29uZmlndXJlZCI6ZmFsc2UsImF1dG9j
b25uZWN0IjpmYWxzZSwib25saW5lIjpmYWxzZSwicmVhZHkiOmZhbHNlfSwKImQ4M2FkZGE2ODU0
OF80YzY5NzY2OTZlNjcyMDUyNmY2ZjZkMjA1NDU2Ijp7InByaW1hcnlEbnMiOiIxOTIuMTY4LjIu
MjUzIiwic2Vjb25kYXJ5RG5zIjoiIiwic2VjdXJpdHkiOiJOT05FIiwic3RyZW5ndGgiOiIzNyIs
InN0cmVuZ3RoU3RhcnMiOiIgJiM5NzMzICYjOTczMyAmIzk3MzMgJiM5NzMzIiwiZGVmYXVsdEdh
dGV3YXkiOiIxOTIuMTY4LjIuMjU0IiwiaXB2NE1hc2siOiIyNTUuMjU1LjI1NS4wIiwiaXB2Ni5t
ZXRob2QiOiJhdXRvIiwiaXB2Ni5wcml2YWN5IjoiZGlzYWJsZWQiLCJzc2lkIjoiTGl2aW5nIFJv
b20gVFYiLCJzc2lkSGV4IjoiNGM2OTc2Njk2ZTY3MjA1MjZmNmY2ZDIwNTQ1NiIsInN0YXR1cyI6
IiIsImNvbm5tYW5TdHJpbmciOiJ3aWZpX2Q4M2FkZGE2ODU0OF80YzY5NzY2OTZlNjcyMDUyNmY2
ZjZkMjA1NDU2X21hbmFnZWRfbm9uZSIsIm1hY0FkZHJlc3MiOiJkODNhZGRhNjg1NDgiLCJ0ZWNo
bm9sb2d5Ijoid2lmaSIsIm5pYyI6IndsYW4wIiwiY29uZmlndXJlZCI6ZmFsc2UsImF1dG9jb25u
ZWN0IjpmYWxzZSwib25saW5lIjpmYWxzZSwicmVhZHkiOmZhbHNlfSwKImQ4M2FkZGE2ODU0OF81
YTRkNTg1ZjMzMzQzNiI6eyJwcmltYXJ5RG5zIjoiMTkyLjE2OC4yLjI1MyIsInNlY29uZGFyeURu
cyI6IiIsInNlY3VyaXR5IjoiUFNLIiwic3RyZW5ndGgiOiI0MSIsInN0cmVuZ3RoU3RhcnMiOiIg
JiM5NzMzICYjOTczMyAmIzk3MzMgJiM5NzMzIiwiZGVmYXVsdEdhdGV3YXkiOiIxOTIuMTY4LjIu
MjU0IiwiaXB2NE1hc2siOiIyNTUuMjU1LjI1NS4wIiwiaXB2Ni5tZXRob2QiOiJhdXRvIiwiaXB2
Ni5wcml2YWN5IjoiZGlzYWJsZWQiLCJzc2lkIjoiWk1YXzM0NiIsInNzaWRIZXgiOiI1YTRkNTg1
ZjMzMzQzNiIsInN0YXR1cyI6IiIsImNvbm5tYW5TdHJpbmciOiJ3aWZpX2Q4M2FkZGE2ODU0OF81
YTRkNTg1ZjMzMzQzNl9tYW5hZ2VkX3BzayIsIm1hY0FkZHJlc3MiOiJkODNhZGRhNjg1NDgiLCJ0
ZWNobm9sb2d5Ijoid2lmaSIsIm5pYyI6IndsYW4wIiwiY29uZmlndXJlZCI6ZmFsc2UsImF1dG9j
b25uZWN0IjpmYWxzZSwib25saW5lIjpmYWxzZSwicmVhZHkiOmZhbHNlfSwKImQ4M2FkZGE2ODU0
OF80ZTQ1NTQ0NzQ1NDE1MjM5MzUiOnsicHJpbWFyeURucyI6IjE5Mi4xNjguMi4yNTMiLCJzZWNv
bmRhcnlEbnMiOiIiLCJzZWN1cml0eSI6IlBTSyIsInN0cmVuZ3RoIjoxOSwic3RyZW5ndGhTdGFy
cyI6IiAmIzk3MzMgJiM5NzMzIiwiZGVmYXVsdEdhdGV3YXkiOiIxOTIuMTY4LjIuMjU0IiwiaXB2
NE1hc2siOiIyNTUuMjU1LjI1NS4wIiwiaXB2Ni5tZXRob2QiOiJhdXRvIiwiaXB2Ni5wcml2YWN5
IjoiZGlzYWJsZWQiLCJzc2lkIjoiTkVUR0VBUjk1Iiwic3NpZEhleCI6IjRlNDU1NDQ3NDU0MTUy
MzkzNSIsInN0YXR1cyI6IiIsImNvbm5tYW5TdHJpbmciOiJ3aWZpX2Q4M2FkZGE2ODU0OF80ZTQ1
NTQ0NzQ1NDE1MjM5MzVfbWFuYWdlZF9wc2siLCJtYWNBZGRyZXNzIjoiZDgzYWRkYTY4NTQ4Iiwi
dGVjaG5vbG9neSI6IndpZmkiLCJuaWMiOiJ3bGFuMCIsImNvbmZpZ3VyZWQiOmZhbHNlLCJhdXRv
Y29ubmVjdCI6ZmFsc2UsIm9ubGluZSI6ZmFsc2UsInJlYWR5IjpmYWxzZX0sCiJkODNhZGRhNjg1
NDhfNDc2ZjZlN2E2MTZjNjU3YTJkNTI2OTc2NjU3MjYxMjA0NjYxNmQ2OTZjNzkiOnsicHJpbWFy
eURucyI6IjE5Mi4xNjguMi4yNTMiLCJzZWNvbmRhcnlEbnMiOiIiLCJzZWN1cml0eSI6IlBTSyIs
InN0cmVuZ3RoIjoiNDciLCJzdHJlbmd0aFN0YXJzIjoiICYjOTczMyAmIzk3MzMgJiM5NzMzICYj
OTczMyAmIzk3MzMiLCJkZWZhdWx0R2F0ZXdheSI6IjE5Mi4xNjguMi4yNTQiLCJpcHY0TWFzayI6
IjI1NS4yNTUuMjU1LjAiLCJpcHY2Lm1ldGhvZCI6ImF1dG8iLCJpcHY2LnByaXZhY3kiOiJkaXNh
YmxlZCIsInNzaWQiOiJHb256YWxlei1SaXZlcmEgRmFtaWx5Iiwic3NpZEhleCI6IjQ3NmY2ZTdh
NjE2YzY1N2EyZDUyNjk3NjY1NzI2MTIwNDY2MTZkNjk2Yzc5Iiwic3RhdHVzIjoiIiwiY29ubm1h
blN0cmluZyI6IndpZmlfZDgzYWRkYTY4NTQ4XzQ3NmY2ZTdhNjE2YzY1N2EyZDUyNjk3NjY1NzI2
MTIwNDY2MTZkNjk2Yzc5X21hbmFnZWRfcHNrIiwibWFjQWRkcmVzcyI6ImQ4M2FkZGE2ODU0OCIs
InRlY2hub2xvZ3kiOiJ3aWZpIiwibmljIjoid2xhbjAiLCJjb25maWd1cmVkIjpmYWxzZSwiYXV0
b2Nvbm5lY3QiOmZhbHNlLCJvbmxpbmUiOmZhbHNlLCJyZWFkeSI6ZmFsc2V9LAoiZDgzYWRkYTY4
NTQ4XzRkNjE3MjYzNjg2MTZlIjp7InByaW1hcnlEbnMiOiIxOTIuMTY4LjIuMjUzIiwic2Vjb25k
YXJ5RG5zIjoiIiwic2VjdXJpdHkiOiJQU0siLCJzdHJlbmd0aCI6MzgsInN0cmVuZ3RoU3RhcnMi
OiIgJiM5NzMzICYjOTczMyAmIzk3MzMgJiM5NzMzIiwiZGVmYXVsdEdhdGV3YXkiOiIxOTIuMTY4
LjIuMjU0IiwiaXB2NE1hc2siOiIyNTUuMjU1LjI1NS4wIiwiaXB2Ni5tZXRob2QiOiJhdXRvIiwi
aXB2Ni5wcml2YWN5IjoiZGlzYWJsZWQiLCJzc2lkIjoiTWFyY2hhbiIsInNzaWRIZXgiOiI0ZDYx
NzI2MzY4NjE2ZSIsInN0YXR1cyI6IiIsImNvbm5tYW5TdHJpbmciOiJ3aWZpX2Q4M2FkZGE2ODU0
OF80ZDYxNzI2MzY4NjE2ZV9tYW5hZ2VkX3BzayIsIm1hY0FkZHJlc3MiOiJkODNhZGRhNjg1NDgi
LCJ0ZWNobm9sb2d5Ijoid2lmaSIsIm5pYyI6IndsYW4wIiwiY29uZmlndXJlZCI6ZmFsc2UsImF1
dG9jb25uZWN0IjpmYWxzZSwib25saW5lIjpmYWxzZSwicmVhZHkiOmZhbHNlfSwKImQ4M2FkZGE2
ODU0OF80NjY1NzI2ZTYxNmU2NDY1N2EiOnsicHJpbWFyeURucyI6IjE5Mi4xNjguMi4yNTMiLCJz
ZWNvbmRhcnlEbnMiOiIiLCJzZWN1cml0eSI6IlBTSyIsInN0cmVuZ3RoIjoyNywic3RyZW5ndGhT
dGFycyI6IiAmIzk3MzMgJiM5NzMzICYjOTczMyIsImRlZmF1bHRHYXRld2F5IjoiMTkyLjE2OC4y
LjI1NCIsImlwdjRNYXNrIjoiMjU1LjI1NS4yNTUuMCIsImlwdjYubWV0aG9kIjoiYXV0byIsImlw
djYucHJpdmFjeSI6ImRpc2FibGVkIiwic3NpZCI6IkZlcm5hbmRleiIsInNzaWRIZXgiOiI0NjY1
NzI2ZTYxNmU2NDY1N2EiLCJzdGF0dXMiOiIiLCJjb25ubWFuU3RyaW5nIjoid2lmaV9kODNhZGRh
Njg1NDhfNDY2NTcyNmU2MTZlNjQ2NTdhX21hbmFnZWRfcHNrIiwibWFjQWRkcmVzcyI6ImQ4M2Fk
ZGE2ODU0OCIsInRlY2hub2xvZ3kiOiJ3aWZpIiwibmljIjoid2xhbjAiLCJjb25maWd1cmVkIjpm
YWxzZSwiYXV0b2Nvbm5lY3QiOmZhbHNlLCJvbmxpbmUiOmZhbHNlLCJyZWFkeSI6ZmFsc2V9LAoi
ZDgzYWRkYTY4NTQ4XzQ5NTM0ZDZmNzM3MzYxNjQ0NjM4Ijp7InByaW1hcnlEbnMiOiIxOTIuMTY4
LjIuMjUzIiwic2Vjb25kYXJ5RG5zIjoiIiwic2VjdXJpdHkiOiJQU0siLCJzdHJlbmd0aCI6IjMw
Iiwic3RyZW5ndGhTdGFycyI6IiAmIzk3MzMgJiM5NzMzICYjOTczMyIsImRlZmF1bHRHYXRld2F5
IjoiMTkyLjE2OC4yLjI1NCIsImlwdjRNYXNrIjoiMjU1LjI1NS4yNTUuMCIsImlwdjYubWV0aG9k
IjoiYXV0byIsImlwdjYucHJpdmFjeSI6ImRpc2FibGVkIiwic3NpZCI6IklTTW9zc2FkRjgiLCJz
c2lkSGV4IjoiNDk1MzRkNmY3MzczNjE2NDQ2MzgiLCJzdGF0dXMiOiIiLCJjb25ubWFuU3RyaW5n
Ijoid2lmaV9kODNhZGRhNjg1NDhfNDk1MzRkNmY3MzczNjE2NDQ2MzhfbWFuYWdlZF9wc2siLCJt
YWNBZGRyZXNzIjoiZDgzYWRkYTY4NTQ4IiwidGVjaG5vbG9neSI6IndpZmkiLCJuaWMiOiJ3bGFu
MCIsImNvbmZpZ3VyZWQiOmZhbHNlLCJhdXRvY29ubmVjdCI6ZmFsc2UsIm9ubGluZSI6ZmFsc2Us
InJlYWR5IjpmYWxzZX0sCiJkODNhZGRhNjg1NDhfNDE2ZTc0NzM1MDYxNmU3NDczNWY0NTU4NTQi
OnsicHJpbWFyeURucyI6IjE5Mi4xNjguMi4yNTMiLCJzZWNvbmRhcnlEbnMiOiIiLCJzZWN1cml0
eSI6IlBTSyIsInN0cmVuZ3RoIjoiMjciLCJzdHJlbmd0aFN0YXJzIjoiICYjOTczMyAmIzk3MzMg
JiM5NzMzIiwiZGVmYXVsdEdhdGV3YXkiOiIxOTIuMTY4LjIuMjU0IiwiaXB2NE1hc2siOiIyNTUu
MjU1LjI1NS4wIiwiaXB2Ni5tZXRob2QiOiJhdXRvIiwiaXB2Ni5wcml2YWN5IjoiZGlzYWJsZWQi
LCJzc2lkIjoiQW50c1BhbnRzX0VYVCIsInNzaWRIZXgiOiI0MTZlNzQ3MzUwNjE2ZTc0NzM1ZjQ1
NTg1NCIsInN0YXR1cyI6IiIsImNvbm5tYW5TdHJpbmciOiJ3aWZpX2Q4M2FkZGE2ODU0OF80MTZl
NzQ3MzUwNjE2ZTc0NzM1ZjQ1NTg1NF9tYW5hZ2VkX3BzayIsIm1hY0FkZHJlc3MiOiJkODNhZGRh
Njg1NDgiLCJ0ZWNobm9sb2d5Ijoid2lmaSIsIm5pYyI6IndsYW4wIiwiY29uZmlndXJlZCI6ZmFs
c2UsImF1dG9jb25uZWN0IjpmYWxzZSwib25saW5lIjpmYWxzZSwicmVhZHkiOmZhbHNlfX0K
--000000000000d7ebac0616376494--
