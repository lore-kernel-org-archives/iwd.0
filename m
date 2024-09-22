Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B512CA7
	for <iwd@lists.linux.dev>; Sun, 22 Sep 2024 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727022051; cv=none; b=n8C+T8zNStpdXAP6URthkryE10fuTrdXL2Bm51FwclvSODeI8rnwPuhxYoJUp2HDQ6EaaOpTIEfr1T0LeMAyqi3pnJGH5D92FiagOwyus31cEyOMF0r6p1udBaZx2bHMVLz0oS4X2+tvlnJqeEVu/FEWXkaPOMZLkUQobMYPp54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727022051; c=relaxed/simple;
	bh=s2fGC15RUknATNi7jpf7aIswEVVC9gsUWSiFw0BczWI=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=AYqW7mUfq8+iQumptJRT/vzr/Y/m1TXN81F+S4cOk5nSbqsq9dMRhoDYeYNR0hg8d/i7yZAwN6irWBg3ave/B5ww8l9nnUo7moxv3vK/I/VAH/ejzrj/VjMvZRcnFcciS/0dhGuLUu8HExV3A6LiC0ZHz0ruv9m8Bh5FH+orUMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AVr1VJsy; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AVr1VJsy"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a90188ae58eso441058066b.1
        for <iwd@lists.linux.dev>; Sun, 22 Sep 2024 09:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1727022048; x=1727626848; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iak9VTmzQvXYxMIhQkc/TbGFykHE2xxWZfaa/92dd40=;
        b=AVr1VJsysPBrCfpmlug+PYO3uMoE7zGX2z2hnqZc5ZSnjcjAHvnXYpZcbHO717bz41
         jeF03P38rmykO9rvO63OO4xo5OwlUc1QnTWMyUd2df/5LLYYuUe7KSbdBLnZ7PjJhQDI
         WH3DAO4ST3k7AKHgi35ecJ7lsLnxcl8tgQ3gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727022048; x=1727626848;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iak9VTmzQvXYxMIhQkc/TbGFykHE2xxWZfaa/92dd40=;
        b=K/8KEH6o4SaRW+XmMpE0K7TLiqzmvGQpqBQSzVU+6D8Wws3TXNyN00PboIW9b6dc3O
         E8Gljpt9Eu6VSU01jnU8H5S6qf890kYoBzjLkCa6h8S3WhEffUbD2WaVDOjsRIRdDhTd
         g1fQGIuRMUz+EwuV+aVOLL2+rMDOLUjLuedIfoeUtPDMizBSlUJ6CP5UNWTJQqQoHKxs
         4tNKNIP/pHUXEUqqkYv+V46VvP5Z6vUEDZGt7sdjYws2CAmgKS6gsOI0WL3wu5otAnqK
         R+fRAMoPltvjOZJt9sKtp1ZPF5LpyaVkU9F1UIbADcOflljsGnwS8acqkRUm81akDjGs
         VPsw==
X-Forwarded-Encrypted: i=1; AJvYcCVGVnarmFO5zZC1/txOKohpmmsr2+WwNL5FO/03Uphg7ownntc/nELGN4XY3vjC56JaLNg=@lists.linux.dev
X-Gm-Message-State: AOJu0YzirZLQa9wtHFG75KXFF7Ci9pcNje0HC2h4q6aL3qtU9wxuyeex
	h2nvzw1FrIkE5AidEoXqKKsU6Ym8gVJ4bQx2hqKGySKcF5z9SM8xH8a9my1sLw==
X-Google-Smtp-Source: AGHT+IEYhWLvPKW13MNwsAji63yaK/MWzGeD1O+Kjh8G0DjBJlgXIK8g/s1HEWaU3C9+zMZSqLw1Ug==
X-Received: by 2002:a17:907:3e20:b0:a86:8f8f:4761 with SMTP id a640c23a62f3a-a90d56dffb1mr966303266b.25.1727022047948;
        Sun, 22 Sep 2024 09:20:47 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a906111aa91sm1099601066b.97.2024.09.22.09.20.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Sep 2024 09:20:47 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: KeithG <ys3al35l@gmail.com>
CC: Denis Kenzior <denkenz@gmail.com>, Yuxuan Shui <yshuiv7@gmail.com>, <iwd@lists.linux.dev>, <prestwoj@gmail.com>
Date: Sun, 22 Sep 2024 18:20:47 +0200
Message-ID: <1921a891f18.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <CAG17S_PAm0NsA+oRho5Qt-Y8MowB4nkeOnugzaE==pWLSpGYpg@mail.gmail.com>
References: <20240823174220.498594-1-denkenz@gmail.com>
 <20240921185902.170612-1-yshuiv7@gmail.com>
 <ba78a253-de77-4427-85c3-d876ef9fdd8a@gmail.com>
 <1921859cb98.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_PAm0NsA+oRho5Qt-Y8MowB4nkeOnugzaE==pWLSpGYpg@mail.gmail.com>
User-Agent: AquaMail/1.52.0 (build: 105200518)
Subject: Re: [RFC PATCH v1 0/2] External Auth support
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On September 22, 2024 5:36:53 PM KeithG <ys3al35l@gmail.com> wrote:

> On Sun, Sep 22, 2024 at 1:09 AM Arend Van Spriel
> <arend.vanspriel@broadcom.com> wrote:
>>
>> On September 22, 2024 5:35:03 AM Denis Kenzior <denkenz@gmail.com> wrote:
>>
>>> Hi Yuxuan Shui,
>>>
>>>>
>>>> I tested this on an RPi5 too, and indeed I am having the same problem as KeithG
>>>> as well. However I managed to get some debug information from brcmfmac when
>>>> running wpa_supplicant. Interestingly wpa_supplicant gets the same -52 error as
>>>> well, which it reports as an authentication timeout. But if I ask it to try
>>>> again, it will connect successfully, and there is no external auth related log
>>>> the second time around.
>>>
>>> Yep.  It looks like wpa_s puts the resulting PMKSA into the kernel cache even
>>> though the initial connection using external auth fails.  I've only seen
>>> 2.10 do
>>> this, not 2.11.  Either way, it is a bug / lucky coincidence.
>>>
>>>>
>>>> So I suspect this is a firmware bug, but it should be relatively easy to
>>>> workaround I think? Basically we also add a timeout and retry.
>>>
>>> It would be far nicer if the brcmfmac firmware + driver combination worked
>>> properly :)
>>
>> Indeed it would. So what's in the mix? What kernel is used? Upstream or RPi
>> kernel? What firmware capabilities are listed in debugfs?
>>
>> Recently I submitted patches upstream to add external auth support. As I
>> ported downstream patch the results you see do not make me optimistic that
>> my patch is ready. Maybe you could help testing it?
>>
>> https://patchwork.kernel.org/project/linux-wireless/list/?series=891248&state=*
>>
>> Regards,
>> Arend
> Arend,
>
> I tried to apply the patch set to kernel 6.6.44-v8 and was unable to patch it:
>
> $ patch -p1 < 
> RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg80211-callbacks-and-firmware-events.patch
> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> Hunk #1 FAILED at 6752.
> 1 out of 1 hunk FAILED -- saving rejects to file
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c.rej
> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
> Hunk #1 succeeded at 524 (offset 33 lines).
> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> Hunk #1 FAILED at 1359.
> 1 out of 1 hunk FAILED -- saving rejects to file
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c.rej
> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
> Hunk #1 succeeded at 74 (offset -1 lines).
> Hunk #2 succeeded at 336 (offset -70 lines).
> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
> Hunk #1 FAILED at 15.
> Hunk #2 succeeded at 47 with fuzz 1 (offset -9 lines).
> 1 out of 2 hunks FAILED -- saving rejects to file
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h.rej
>
> I did not try the other patches as this attempt failed. Do I need to
> use a newer kernel? The latest kernel from RPiOS is 6.6.47.

I did major rework to support multiple vendors with differing firmware 
APIs. So I can imagine you would need other patches that were submitted 
earlier. Easiest would be to use the backports project which allows running 
latest driver like wireless-next on older kernels.

I can try. Do you have a URL of the RPiOS kernel repo?

Regards,
Arend
> Keith



