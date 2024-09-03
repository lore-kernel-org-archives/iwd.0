Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2891C14
	for <iwd@lists.linux.dev>; Tue,  3 Sep 2024 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725383033; cv=none; b=kEw2qztHTg0c7Yikbg+D6w6JCtAnpSzCS7peFlkazRXeibOy+b+KMUAQuGvs09ZrQl2X3Tw88r4HHw9cXd9mXkFKmA92PemIlYlkBfI1r1WwmP2sWdC/1xBU32rCsqtnKmdNbiE/gnCk94e0HawUUlVKvKcyoCTEmvZXDz9TlOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725383033; c=relaxed/simple;
	bh=GP7+m5O3BflofD3MqyHarp4XFirKeNrlhMLSD6LsDQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ORKKJL3MxxfqVeio+MYkun7mcApkg6Whd5iPHOTTLnzWUJm5KO/40JYU/gADeMjK2qfxt6nIy0ZgVdyGrsYnYP60sX8yGwnInbn3puv3ygnlR3EGky+xiJjPiA0IvP5jUiWVmpyzThLPEraAMeLIti4S2XKUvzQza8ZLpyPHG00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYBYbe1E; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYBYbe1E"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a86abbd68ffso927153866b.0
        for <iwd@lists.linux.dev>; Tue, 03 Sep 2024 10:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725383030; x=1725987830; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YLRtfFQKsWPv0957HyMHbyPzEGQeVKn2los5xWlVuHs=;
        b=eYBYbe1E1D2u/zXjiHQUaJatWfAjSzk/Z1J8CF7waHlI6kx0+P2yrqWLOghFSfW0NL
         tDTGB5orphYHq8V2HiRxXwmZGxjVtMIEAMIY4l7KY1enV0Kd908Wzde5s7x0eXXjzaMm
         l9yN3adpyjZkZULj8TFJDZtJWi84mSNxltES5pR3P6bkeLoGE2q9G3HI4HfkL5O/VhT3
         ZkdfOmh7Mu1fBbYo4o6Xc7W7uEgZBYPMUYciZ0eavWq3EOhSu7lrfAgOwgjqAnueO6mb
         BhHONV6TIImrmjcBOwdm+Pwf9FujsMKp0AWdSEJTFdUTccVIcuL1pjytzBcBVG0QRNR3
         1s8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725383030; x=1725987830;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YLRtfFQKsWPv0957HyMHbyPzEGQeVKn2los5xWlVuHs=;
        b=m+SgF9D69Qnk8OC/bd1e0tXqUPjNnlC0IN+pysFDwt4cBZxfNBEisO/y650rllIU5D
         ejVQV+2v0OKZNXjTclpMY/+c/8nQmsLyhaYlnBiuhzDsEmS/5JGVOO4yBfgQlFCOmPfN
         HKyCD8+lScwokDZbViDR0GWWaYF331XVvZX6MO/azfoJq7M9WdqbXJLmybajAfQM9LrU
         O3lvo1+QK/1g/ttwzUuVRiPljjYmPy2PubQUVNgNjYZrxvECS3dg1cN/B10chcbnLSzX
         KP9zJohixkwmjbhy6cbP7iuomzRBtf4u7s272K6NWE6YQCeoVVtTwDFEcx5qD5d8i3zO
         YLoA==
X-Gm-Message-State: AOJu0YwFiTYTOnfTnpJVWvX5mwDJhjKnvpvj6o7ZzPiXfsbreO6CjfJA
	OCvFfrTVb+7FGvUt0Z7IIi+1Hez6nOwraw6wNhQVzyTVZTj3j8+cBuBnmxUrKscgxGTLKWFtBRC
	SZjB3RYX1y6SGfc6qFzDzv5sL7eE=
X-Google-Smtp-Source: AGHT+IGXMrSaJR4mhzdqMm/S00+vX6EtyrMmsiFR9ct2IUKMUHtNSRQk/sbSySfyu+2Ugv6hTdM10M8tCR9pwpTgrEI=
X-Received: by 2002:a17:907:f1c3:b0:a7a:b561:358e with SMTP id
 a640c23a62f3a-a89a29ed3e2mr1480334866b.33.1725383029854; Tue, 03 Sep 2024
 10:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAO=WXSdnr7q2uJwEBvmrsfu+qpVCSTj0WVkKeRmPZi=TgTfYcw@mail.gmail.com>
 <4083bf62-20d2-46e6-bfae-c926c2acbfe9@gmail.com>
In-Reply-To: <4083bf62-20d2-46e6-bfae-c926c2acbfe9@gmail.com>
From: Daniel Bond <danielbondno@gmail.com>
Date: Tue, 3 Sep 2024 19:03:21 +0200
Message-ID: <CAO=WXSceTK1S0WgtG5cRt1B_Liq-JLqZMAxqUsHmfLkLc45PFA@mail.gmail.com>
Subject: Re: [PATCH 1/2] scan: fix invalid read when canceling an ongoing scan
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: multipart/mixed; boundary="00000000000098b22906213a0abe"

--00000000000098b22906213a0abe
Content-Type: text/plain; charset="UTF-8"

Sounds good. I'm not sure where to send it with git send-email, but
I've attached the patch against current HEAD of iwd. If you want me to
do something else just point me in the right direction.

Thanks!

Br, Daniel

On Tue, 3 Sept 2024 at 13:44, James Prestwood <prestwoj@gmail.com> wrote:
>
> Hi Daniel,
>
> On 9/1/24 11:34 PM, Daniel Bond wrote:
> > Hi,
> >
> > There was reported an issue reported in the Arch Linux issue tracker,
> > which I also experienced on my hardware after upgrading iwd to version
> > 2.20. What happens is that iwd constantly segfaults with messages like
> > this:
> >
> > [  279.974994] Code: 00 00 00 00 f3 0f 1e fa 55 48 89 e5 41 57 41 56
> > 41 55 41 54 53 48 83 ec 18 48 89 4d c8 4c 89 45 c0 48 85 ff 0f 84 f3
> >   00 00 00 <80> 7e 20 00 49 89 f5 0f 85 e6 00 00 00 48 83 fa 01 48 89 fb 49 89
> > [  280.685109] iwd[1648]: segfault at 32 ip 0000788413f05de6 sp
> > 00007ffeb3d023d0 error 4 in libell.so.0.0.2[1ade6,788413efb000+57000]
> > lik
> > ely on CPU 1 (core 1, socket 0)
> > [  280.685125] Code: 00 00 00 00 f3 0f 1e fa 55 48 89 e5 41 57 41 56
> > 41 55 41 54 53 48 83 ec 18 48 89 4d c8 4c 89 45 c0 48 85 ff 0f 84 f3
> >   00 00 00 <80> 7e 20 00 49 89 f5 0f 85 e6 00 00 00 48 83 fa 01 48 89 fb 49 89
> > [  290.573368] iwd[1686]: segfault at 32 ip 00007c0b35d49de6 sp
> > 00007fff86c509d0 error 4 in libell.so.0.0.2[1ade6,7c0b35d3f000+57000]
> > lik
> > ely on CPU 2 (core 0, socket 0)
> >
> > The issue seems to be resolved by checking that results->sr is set:
> >
> > - if (!results->sr->canceled)
> > + if (results->sr && !results->sr->canceled)
> The patch on the arch issue report looks good to me. Can we go ahead and
> just send that patch with git send-email?
> >
> > More information reported in the arch linux gitlab issuetracker, under
> > gitlab archlinux org /archlinux/packaging/packages/iwd/-/issues/5 .
> >
> > In advance, thanks.
> >
> > Br, Daniel Bond

--00000000000098b22906213a0abe
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-scan-add-guard-to-check-that-results-sr-is-set-to-av.patch"
Content-Disposition: attachment; 
	filename="0001-scan-add-guard-to-check-that-results-sr-is-set-to-av.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m0mohdj60>
X-Attachment-Id: f_m0mohdj60

RnJvbSBhY2ZkZTMyZjY1YzIzYjAwYTA4OTNiNjRiOGJjMGFiOGVlYjM5MTQzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgQm9uZCA8ZGFuaWVsYm9uZG5vQGdtYWlsLmNvbT4K
RGF0ZTogVHVlLCAzIFNlcCAyMDI0IDE4OjUyOjU2ICswMjAwClN1YmplY3Q6IFtQQVRDSF0gc2Nh
bjogYWRkIGd1YXJkIHRvIGNoZWNrIHRoYXQgcmVzdWx0cy0+c3IgaXMgc2V0IHRvIGF2b2lkCiBz
ZWdmYXVsdCBpc3N1ZS4KClBhdGNoIGNyZWF0ZWQgYnkgbG9xcyBpbiBBcmNobGludXggaXNzdWU6
IGh0dHBzOi8vZ2l0bGFiLmFyY2hsaW51eC5vcmcvYXJjaGxpbnV4L3BhY2thZ2luZy9wYWNrYWdl
cy9pd2QvLS9pc3N1ZXMvNQoKQXMgbWVudGlvbmVkIGluIGxpc3Q6IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2l3ZC80MDgzYmY2Mi0yMGQyLTQ2ZTYtYmZhZS1jOTI2YzJhY2JmZTlAZ21haWwuY29t
LwotLS0KIHNyYy9zY2FuLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9zcmMvc2Nhbi5jIGIvc3JjL3NjYW4uYwppbmRl
eCBkZWJkZWIxZi4uZTUzNjBkMWIgMTAwNjQ0Ci0tLSBhL3NyYy9zY2FuLmMKKysrIGIvc3JjL3Nj
YW4uYwpAQCAtMjA1Niw3ICsyMDU2LDcgQEAgc3RhdGljIHZvaWQgZ2V0X3N1cnZleV9kb25lKHZv
aWQgKnVzZXJfZGF0YSkKIAogCXNjLT5nZXRfc3VydmV5X2NtZF9pZCA9IDA7CiAKLQlpZiAoIXJl
c3VsdHMtPnNyLT5jYW5jZWxlZCkKKwlpZiAocmVzdWx0cy0+c3IgJiYgIXJlc3VsdHMtPnNyLT5j
YW5jZWxlZCkKIAkJZ2V0X3Jlc3VsdHMocmVzdWx0cyk7CiAJZWxzZQogCQlnZXRfc2Nhbl9kb25l
KHVzZXJfZGF0YSk7Ci0tIAoyLjQ2LjAKCg==
--00000000000098b22906213a0abe--
