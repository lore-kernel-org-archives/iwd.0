Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C4E11712
	for <iwd@lists.linux.dev>; Sun, 22 Sep 2024 06:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726985396; cv=none; b=H0ojSO8b8EIGVc21u40Sjh0i2Pve4V9WTsN0tdgYdzKKuolLZNzxKBLao5Dl6Vz8TMOmPo2/YLV36vvq/p4eD/iEKIWEFL2aQpil1mD9fu8f+oDUNbt70Bv6CTu7taTqg5vwgMr7ELFhr7lEoEZv5/ZYPMriov2rpAdMsrfEkaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726985396; c=relaxed/simple;
	bh=NeJvGiWHG5DhJY+KQ3AjbAgA9WJ7aL+lX3oMyFaMDCs=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=qyWhm7Ifa3k+5YMnSZZ76VJVlWFv2bdf5UcdYyYnS+mZtsNjcNcUmrj5t8vccLZWxxqnF7PrKgP+hKx1LF+h5F9OMeB+3Nj5JnaALikWHKMwsaa6t4Sa934fcpFIKtK9djsAu8oAtRTPDGAEeDtchEAwlbO/fq2qKzC0CakSM34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XWMrzvFh; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XWMrzvFh"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c245c62362so4147767a12.0
        for <iwd@lists.linux.dev>; Sat, 21 Sep 2024 23:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726985393; x=1727590193; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CI27S9lhSFCvOWoe6//QkN7zhI/MeSzE7HNJJ9dU3EI=;
        b=XWMrzvFh7wafWSsc3PY63PTpqYu8ynlTc4rivkQepBTuc9z/A+uK9zXobVs4sVIB+8
         Uo/E+Bk9SDv581ZXb/6yz0/8/9ViSn1SLnItRi1c5K/XWrKMakw3E6U/QlikzWjzGIBK
         cA1I7Y13WmUXwKnJd5gXbwazWgh1cmqHP2X/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726985393; x=1727590193;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CI27S9lhSFCvOWoe6//QkN7zhI/MeSzE7HNJJ9dU3EI=;
        b=fT4P2JgQ3fuFrvzxR+IBhjhz80M69B7DUQJ/yU/tahaj1EfPoaqU9yZEDsyqxa76ln
         NiFqT64ZzKq4efgRk0H54qguSTUEKmpevZMnQfBCf+eEoVUGPSgsjRg7We1HfcDccuNm
         yLmbq60Qy+ucSmUIgGGLMTan591H55xF1yT1goJkdtiYLicm45JWkXI/MbuZAg1wMqBQ
         6RQatH6bdYKrmw9pVcEHf0Mibm95pgjEkVf9boNhi+u6kjrKzAFgmuTlEqujbEbP+L+q
         KfhWPtUdLF5xGmx5Hu47j2XvfFctd7u8DV3tHueJ+Y5wh9326q++kBpvPQnNmVKAiLUb
         tzxA==
X-Gm-Message-State: AOJu0YytOWYkoGPkAjUfx9NMSB6gldH2h0rXlA47feS7I9JhMaSGUyCI
	DhDQP65mRcvAU33DSFPk2DhFChqpOmWaUpcDYxIwhvgzkRi/KhSZlrSwKHmKrg==
X-Google-Smtp-Source: AGHT+IH8qXBsJNQGi7pNpqnuIE0Nysk713Y3D4rrJsHnnPOUvg/JRJdVO4+Jyag4FG51JFv9cgWZNA==
X-Received: by 2002:a05:6402:234e:b0:5c4:2b0f:fef7 with SMTP id 4fb4d7f45d1cf-5c464daabfdmr7319310a12.4.1726985392941;
        Sat, 21 Sep 2024 23:09:52 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb94a01sm8816260a12.91.2024.09.21.23.09.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Sep 2024 23:09:51 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Denis Kenzior <denkenz@gmail.com>, Yuxuan Shui <yshuiv7@gmail.com>, <ys3al35l@gmail.com>
CC: <iwd@lists.linux.dev>, <prestwoj@gmail.com>
Date: Sun, 22 Sep 2024 08:09:51 +0200
Message-ID: <1921859cb98.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <ba78a253-de77-4427-85c3-d876ef9fdd8a@gmail.com>
References: <20240823174220.498594-1-denkenz@gmail.com>
 <20240921185902.170612-1-yshuiv7@gmail.com>
 <ba78a253-de77-4427-85c3-d876ef9fdd8a@gmail.com>
User-Agent: AquaMail/1.52.0 (build: 105200518)
Subject: Re: [RFC PATCH v1 0/2] External Auth support
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On September 22, 2024 5:35:03 AM Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Yuxuan Shui,
>
>>
>> I tested this on an RPi5 too, and indeed I am having the same problem as KeithG
>> as well. However I managed to get some debug information from brcmfmac when
>> running wpa_supplicant. Interestingly wpa_supplicant gets the same -52 error as
>> well, which it reports as an authentication timeout. But if I ask it to try
>> again, it will connect successfully, and there is no external auth related log
>> the second time around.
>
> Yep.  It looks like wpa_s puts the resulting PMKSA into the kernel cache even
> though the initial connection using external auth fails.  I've only seen 
> 2.10 do
> this, not 2.11.  Either way, it is a bug / lucky coincidence.
>
>>
>> So I suspect this is a firmware bug, but it should be relatively easy to
>> workaround I think? Basically we also add a timeout and retry.
>
> It would be far nicer if the brcmfmac firmware + driver combination worked
> properly :)

Indeed it would. So what's in the mix? What kernel is used? Upstream or RPi 
kernel? What firmware capabilities are listed in debugfs?

Recently I submitted patches upstream to add external auth support. As I 
ported downstream patch the results you see do not make me optimistic that 
my patch is ready. Maybe you could help testing it?

https://patchwork.kernel.org/project/linux-wireless/list/?series=891248&state=*

Regards,
Arend


