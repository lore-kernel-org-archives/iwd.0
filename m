Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C0B1C2316
	for <iwd@lists.linux.dev>; Thu, 30 May 2024 12:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717071419; cv=none; b=cK+sBPlKAr8nMDs1+kOrx5Ca65M8iW5vPu79+xxjoqFxJl1KCzXA0dwnSVZibM1t43zVSJnN/7l1Zhw9hd2Op2kNfM2YbyrdOS7b+enDiM/C1KS5Ju/PeojE4bVEJreuiLWsxMNjjyXCHE64BlolLpVA4NGLHJts/yHA94X+7AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717071419; c=relaxed/simple;
	bh=YFFjIjORx/UbmqD83v+xhPDgeAzZkDHZHierkOcCRhc=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=FPD3hSMbzMiwbI2MGhIhiBQw9PYencr4ju9KWagp8AviQTZLVobfeSY/uyhqPrPcazuuTW8LaVSw6+3RxsXwjXMR6M3HvoZlnDqOrRbvIGRdpnn+xsdeW9HPOe4o6WQ6SgoTwFt5E9oOJlumxZNugqRUc66ku3Fm5H2GkFOummE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=peeters.gent; spf=pass smtp.mailfrom=peeters.gent; dkim=pass (2048-bit key) header.d=peeters.gent header.i=@peeters.gent header.b=D90OYjXI; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=peeters.gent
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peeters.gent
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peeters.gent header.i=@peeters.gent header.b="D90OYjXI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peeters.gent;
	s=protonmail2; t=1717071400; x=1717330600;
	bh=YFFjIjORx/UbmqD83v+xhPDgeAzZkDHZHierkOcCRhc=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=D90OYjXIVzaf59G42K1HZfhi1XbKOpXQtdfPP8t/mQy2wY7J06FYp/HH2pmlOJBNM
	 iTyhgJUOu/U4iwOo2Qd6KveV2v1lY2yabkrR1c4LejmnAAG9Htk1OlkwAXBSQZZ4u2
	 gBSOCSnBM/IYSd0dMZaOktrSjJfO3f06wXUEaZN+I8y0/7KlL4COS8HepJFc3WFPLa
	 9iETzHjoRkN7tT9NCV3VEnX0Iu8/1fU7apNvHPfhaJsg4zwAeELt+et2bWvwv6LLYe
	 erEuSoAQhKxWiz3Bt+4Ut49uf8V8LvpEvORXipBaIRwXSGxMyZ/Ro/AiScxN3GHYsK
	 bhRrqjuqkd1oA==
Date: Thu, 30 May 2024 12:16:34 +0000
To: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
From: Laura Peeters <laura@peeters.gent>
Subject: Bug when ttls start message is sent with tls_msg_len=0?
Message-ID: <tpitoeMEXJxiLQiWJBuau4l3V6w-zuBf8bQVFFXHyArcn6AZBp4Mb5TLsDLxqMLgD_uGDNQ2eKnChB5wbsB82NZpb-KdBfCYrnVcm5kDFRs=@peeters.gent>
Feedback-ID: 91347878:user:proton
X-Pm-Message-ID: ba61bd02a20eb9eae80cba2fd7fd22c74289dbb2
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

hi all,

Recently our radius servers at work got upgraded to freeradius 3.2.4.
It seems to be that in freeradius 3.2.3 and earlier the TTLS start message =
was sent without L flag (and hence without length set)
Freeradius 3.2.4 on the other hand seems to always set te L flag, now the m=
essage gets sent with both S and L flags set (and length as 0). From my ini=
tial reading of the RFC, this seems to be allowed.
This results in iwd throwing a "Fragmented pkt size is outside of allowed b=
oundaries [1, 65536]" error because tls_msg_len is expected to not be zero =
in `eap_tls_init_request_assembly()`.

Because this change in freeradius does not impact any of my coleagues using=
 macOS, windows, or wpa_supplicant, I think it is safe to say that this is =
a bug in iwd, and that a length of zero should be allowed.
I can not seem to find a specific reason why we would need to fail on a len=
gth of zero. allowing zero would in this case hit the `tls_msg_len =3D=3D l=
en` condition and make `eap_tls_init_request_assembly()` return with -ENOMS=
G, which is then correctly handled in `eap_tls_common_handle_request()`

Greetings
Laura

ps: I'm not on the list (given that I'm mostly just a (code-savy) user), so=
 please keep me cc-ed on this issue.
