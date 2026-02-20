Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2C91E7660
	for <iwd@lists.linux.dev>; Fri, 20 Feb 2026 00:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771547183; cv=pass; b=ozosKc5BlDDmv5vBof0wRdzbBsqeOqrxCS9ui10awrN0XyYqrGvQI/9bFZQWVSd3b/KmdU2GuhIwKYS2VAU6O9qQUTxQYTcC1qlybhp4EnmAVciLPBronKRYHFFSFyqQ8uc4JtE0K1g4ej11QJkK5nc6DAUjdN3YBioYRQ1ZaLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771547183; c=relaxed/simple;
	bh=jmm5j97bWXf2HbnOZYrvy/+hUfCgHGEic6nv8+r4FiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSn2tEQnSwWyPgCRpOQrOh8r0L+2DwGuIJXUamxGuWVLbJN8HZWpHyCsbBnZ5ZNEAYzU2o9y3T3Ih2hCVuSMA6ceEaWoXJg3Jr6Tj8+N8LStBZ1aCYKo1EhdfedKc6M5+vZ0D9+6FOXttqskNNxiiS2VC3h7U+drDTkndqJR/TI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnWrkzF8; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnWrkzF8"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b884d5c787bso255838766b.0
        for <iwd@lists.linux.dev>; Thu, 19 Feb 2026 16:26:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771547180; cv=none;
        d=google.com; s=arc-20240605;
        b=fIAe77yVo64WJ/i2I1ltKqoODO0ZYqmKciRss1bjq+w6VSwIB/daXC2lLB3Rrmx+q7
         jA2Q+HJVjs64gHSXRq4uYQXtt4M/8sO4TxXU+UAGtt8uSoeqlUkgN4IOsCp5bNyc/goH
         iwSAZ9W1JVi1WzXJ5LK3r9Z/hc4ZIFoPwDqlefBENxllU3WbO16v5/xzO6NrzL69xWme
         AngW/UqY/0veivxrrr8TWfgqvcklJ6mwW8aGA2aFdkNYAEaqNIF5DqlN1OoLigY4g7Yk
         W1zQxcLuOWrxmvFJxc5cYMYSN39A1JxomgZVwnXshKlay3EVPr37iyPZDHl2XTiKiEz3
         ZM+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jmm5j97bWXf2HbnOZYrvy/+hUfCgHGEic6nv8+r4FiU=;
        fh=lOB+NE21i+DlK11xqGcqr6uTCV2U6X/qbNGHyNqUyZk=;
        b=ehTs/oz+p8OEBUOyf8kxGXOdwrD8aRRNyGslylN4meLlOJamETi1S2YPD3jybCxCsH
         ad2Ok2Wk3D+Ce/FHj2iA0NkdGxvTc2HYSG+LJjvdXOvz6kMdPOA+wAX5zHaJ1t9v5KMb
         etG11YxkgVaN0whPJRHPgHyi3kqYvrjPfXpl3/tm1jtNvNs88/WId6Rg7S/q0M8ZbALi
         dFdF3KR8aI/jqlCufchuKtULryQFMffWqqhdD2gXCxdegccJrOFNT8fn3c5hXm6dRSRv
         E6k7CFrNK4jvP/ljR1ujo9Ez9j2rN2L6U4fcEYhuqpCo+Lc+t/UQCyeDOHzEN9Gaosvq
         xhfQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771547180; x=1772151980; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmm5j97bWXf2HbnOZYrvy/+hUfCgHGEic6nv8+r4FiU=;
        b=gnWrkzF8Yfu49LNoG+5LmrCEzZat76YNTSi3RwCqEArx+ogYnrquXcYU2S56Wc33R4
         eukykjNSjBoKXFxKNk7ywao4qmGCM+FQta9BYefJPCll6gnus9jkhCFfFaGIANOOExjO
         AGUHz1sDBoTYMXf1YLE8EMauIUdg392qj095+NfVGunP2L6DUmuUOmdveWq7vpslLpgo
         2rGx/McngHFdbEe4UYJVe0+BlzazvsWsl3wmysFK94iT6ZARN+RkiC+uFJ0gZ5Jtdo64
         vLp+WIDlPy64xQpCuwVmy4fdB0N+0pzYXgdIFWqYvnQ/9G65ws63AYrRZzpxL0iBhSOY
         ikAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771547180; x=1772151980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jmm5j97bWXf2HbnOZYrvy/+hUfCgHGEic6nv8+r4FiU=;
        b=RwUn9EWZKrDhCB31Z9oOLZ8+kpdDEh5My9rBkjdyQTPs2+gbxwZmJgn0gESZekKfKi
         Q35HItJW3zaWABRwWHG6Ua8nuehy9WjWNK5/mF+vL8n6rRy85x03UOH83xIiA1bZiNQF
         B1zhUSqkW99ArCyCTnAE8zvsVsTTQmOJdir5zwB9hAu93nXkRgarhSrsJXMGYfIG0pVH
         ob20p1s7mEBPsoHlx87sl1w8Kl6zjmjKeoa5+z27AOJOJ2MWdQmdhvL2nOz3DICSg1nq
         JLeEw0TG5JoZ40q0iltf5oRy9S+YCOLa8JKYIID0b7TwjQ1/Hwh7l2YSRdEKzDNVma/Z
         1+dA==
X-Gm-Message-State: AOJu0YzuW6yxqYdvH2v3yQ5ingXsOrYFd7T9bBcqh3qZzr5lGGWFwaqO
	IaQu53VSbCj0lzsiytt95JFuXLFq1DJR88iBpZQvm5AGgxBCOvQatg/3UxyrjVxgEEHXG+96vtm
	Oj8OkyLMCanYu50ck4aVdF0+umDDm5rQ=
X-Gm-Gg: AZuq6aLDIEYNtjETGfzl2xzsboDNQkYbVLJKyW7CjFN5XCduYAKdB7U/iXmjOTE4BYH
	b81aqqfeXtxE5Jz3GWy9WfGC4V5q+NWM3uYsBJfPCljdQNjSI//27Vl7pFJFPzASeZnK5E/qWsh
	lmT0Mt5irj5/HqXpbQKuyx6UxQs1ZD1nF2F5Wr7jpy9Lg3JNWj7b1tiDsC7sgxf6X9VvOdDzbgW
	eXbTbiE8y+4T/sOKJV2Ok9oHCwK8q3WDzAGNCLjveq/zJ1D9YN16Vva81x1LzpNPgKXg1us5BwW
	ehJOJtOQ+NlZC94MVl0T
X-Received: by 2002:a17:907:9487:b0:b79:f4e4:b544 with SMTP id
 a640c23a62f3a-b8fc3a369a5mr1258863566b.21.1771547179423; Thu, 19 Feb 2026
 16:26:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKxU2N9ED1tuKM6ygCb1Ln9VrrMEHGOoc_NhNTn3md87-wH8Mw@mail.gmail.com>
 <d0aa9904-1af1-4505-bbc6-3c75b784e3a9@gmail.com>
In-Reply-To: <d0aa9904-1af1-4505-bbc6-3c75b784e3a9@gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 19 Feb 2026 16:26:08 -0800
X-Gm-Features: AaiRm51Aar8_6pgeYm2Mvta77kitJgp-ufXQWdoaNlnyi5BmQwLIzj2YR2mwdM0
Message-ID: <CAKxU2N_sUr_rmbV5i=MP6c1J7pgZM=f7b1yAUSjg+fDgXNPqTQ@mail.gmail.com>
Subject: Re: does not connect with intel 3168 past kernel 6.16
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 10:03=E2=80=AFAM James Prestwood <prestwoj@gmail.co=
m> wrote:
>
> Hi Rosen,
>
> On 2/11/26 3:15 PM, Rosen Penev wrote:
> > Output from 6.17 dmesg:
> >
> > iwlwifi 0000:08:00.0: enabling device (0000 -> 0002)
> > iwlwifi 0000:08:00.0: Detected crf-id 0x0, cnv-id 0x0 wfpm id 0x0
> > iwlwifi 0000:08:00.0: PCI dev 24fb/2110, rev=3D0x220, rfid=3D0xd55555d5
> > iwlwifi 0000:08:00.0: Detected Intel(R) Dual Band Wireless-AC 3168
> > iwlwifi 0000:08:00.0: loaded firmware version 29.0bd893f3.0
> > 3168-29.ucode op_mode iwlmvm
> > iwlwifi 0000:08:00.0: base HW address: xx:xx:xx:xx:xx:xx, OTP minor ver=
sion: 0x0
> >
> > There's also iwd dmesg spam:
> >
> > invalid HE capabilities for xx:xx:xx:xx:xx:x1
> > invalid HE capabilities for xx:xx:xx:xx:xx:x0
> > event: connect-info, ssid: X, bss: xx:xx:xx:xx:xx:x1, signal: -76, load=
: 52/255
> > event: state, old: autoconnect_quick, new: connecting (auto)
> > event: authentication-timeout,
> > event: connect-failed, status: 1
> > event: connect-info, ssid: X, bss: xx:xx:xx:xx:xx:x0, signal: -78, load=
: 96/255
> > event: authentication-timeout,
> > event: connect-failed, status: 1
> > event: state, old: connecting (auto), new: disconnected
> > event: state, old: disconnected, new: autoconnect_full
> > invalid HE capabilities for xx:xx:xx:xx:xx:x1\
>
> Is there any kernel output during this time?
It's basically this continuously. I use impala to manage iwd but even
if remove it and use iwctl manally, same thing.
>
> >
> > 6.16 output:
> >
> > iwlwifi 0000:08:00.0: enabling device (0000 -> 0002)
> > iwlwifi 0000:08:00.0: Detected crf-id 0x0, cnv-id 0x0 wfpm id 0x0
> > iwlwifi 0000:08:00.0: PCI dev 24fb/2110, rev=3D0x220, rfid=3D0xd55555d5
> > iwlwifi 0000:08:00.0: Detected Intel(R) Dual Band Wireless-AC 3168
> > iwlwifi 0000:08:00.0: loaded firmware version 29.0bd893f3.0
> > 3168-29.ucode op_mode iwlmvm
> > iwlwifi 0000:08:00.0: base HW address: xx:xx:xx:xx:xx:xx, OTP minor ver=
sion: 0x0
> > iwlwifi 0000:08:00.0: Registered PHC clock: iwlwifi-PTP, with index: 1
> >
> > Note the extra PHC clock message.
> >
> > This is still an issue with kernel 6.18. I work around this by using a
> > USB WiFi adapter, which is not ideal.
>
> So the USB adapter does work with 6.18? Do you have any other adapters
> to try? Does wpa_supplicant + iwlwifi adapter work on 6.18?
Not sure, I can try later.
>
> Trying to determine where the issue is. To me, if a USB adapter works
> that tells me its not necessarily an IWD issue, but something with
> iwlwifi and that kernel version. I'd be most interested if
> wpa_supplicant + iwlwifi works, if so we can try getting some iwmon
> logging of the two setups to see what differs.
It's definitely a kernel issue introduced between 6.16 and 6.17. Still
present on 6.18.

Interestingly enough, If I boot to Windows and then reboot to Linux,
it works. But booting directly to Linux fails. That just tells me
firmware loading is broken in some way. Or something is not being
initialized.
>
> Thanks,
>
> James
>
