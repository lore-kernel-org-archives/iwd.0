Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6424C1862BD
	for <iwd@lists.linux.dev>; Wed, 26 Jun 2024 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412995; cv=none; b=SGZbGFsOYHO89rzqj7eFOjWOAmzZ3H9sTswIRMtZF1UMc38qLp8nwtkVWiDK8inycW8xcbp90NH7MYT8sN2Vc8v2+9LWSW2Kd9kcXgeDOyWBvfQDWp57EiwrAVNE2wi5IE2gFaTVPoYsxgJWYb8boK+lg5yVAfqGorKuJGdbRrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412995; c=relaxed/simple;
	bh=uAJynIWv0cH0HoIechkPlh3jjizJHxv7iIgj/WAiCo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G41ZP4N4BVrz5j5ndaPjVg8gg2xN43/uPNz53jyImLkadw5E4S97vtlnY9enjxrTVg6vjS2rAQo/3Rt8Cja7uE1pPJ0GyPUXR9TPE68ydEWof0hvHEXTPDSGTVqMOuFuQnXcNG7JuMvDptwi8p6pvZN+Nss6Jr0tdSslDCJblwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cp0SgUQm; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cp0SgUQm"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3d516d3f0b2so4040442b6e.1
        for <iwd@lists.linux.dev>; Wed, 26 Jun 2024 07:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719412993; x=1720017793; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z+bzJiyhjzd2FC36RtDcrXvIgBPTDEsSIDfjj93r2Qo=;
        b=cp0SgUQmB4J63Egp2xbLaMiMHxstQTWh7nG0HXIPu1BXC94ok3GFFSEcexlcxy+prz
         96E5JetMX157iwScvf9YBqVGxlHqnGeSu/lYl0zIBdBQ6PLHL5+sbqiIscqAHbixBBGD
         4fkctyB6gb03LaTfvpkUd04gtj7voFndo4uPdwq8sbNSzSy2aWJHYt+CiCctQdtlfrhz
         NfIDnDg+qo52L4sLFOECM2wiVgcZl2gIJTo1FRF1ofviVlDwlNGKtoyxLul7Nc0jSwIP
         k0oN7VCeTlyEYkaxfLwSOn/sFjUak1iwrOV+GmejKyjQbXHwhgjewDfVOl1oDc9FdtKU
         iSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719412993; x=1720017793;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+bzJiyhjzd2FC36RtDcrXvIgBPTDEsSIDfjj93r2Qo=;
        b=QsaxkTS0QTiwPzaEwzr2Ll9XDgZMlV1D2MU7HlEED7uT04TKcdoo9BwJ3KnqKzDD1V
         t2Xa7fp5gSCE9OLCBonni2axbXW/9Xo61RKDzA/w9wMaXaOznAamy1ivcWuy1ihMz1SW
         BfA/hlXnBotJ/jFMUBd38qvYq8j+2PiH3huu0fgjf+8Cj9RPQyBNEtYWC+D35r6+lO4+
         FB15Dqv3ltBmlzweiTEN4yqKWndqGOF3AQbiE04BNQw6U6lOVjq1AcbJP+gmmKQNrSei
         Aklip0qfYz0j9kbv2OU9kQdW0bDFrZPrBedeM7HdkgF8dqGy+t+t2EPzoQ/k/r3nIV6G
         ej7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGzqn2A6M7FyNS7Oc8klNfj85etgkvnW7T1vvVsC1sG2mpvqxsgnIO9s2GENb9XBR82CePuh0PKSKKmlifeleDWvrT
X-Gm-Message-State: AOJu0YyI2HA1vEHELfvj0lu6envGCt/OPL4kf+V91vs1Z7kg31I/Zy8O
	S7rrmep8wd8qtDQ1aVnAOEPz3fveEDAbdtm1iKt4gLR4TtMtIcvfc03rRQ==
X-Google-Smtp-Source: AGHT+IHW2BDQQPU02TiGn2vw6uBrl/8VuTb8KOjLbrPu8Q+FG3eNDQQtWsK87b3GigTLJ+ovo/1qEw==
X-Received: by 2002:a05:6808:1485:b0:3d5:2c1c:84a4 with SMTP id 5614622812f47-3d545964553mr13418830b6e.17.1719412993365;
        Wed, 26 Jun 2024 07:43:13 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7009c607a6csm1906257a34.40.2024.06.26.07.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 07:43:12 -0700 (PDT)
Message-ID: <f3af8263-f1ea-4ee3-bfcc-393c54948638@gmail.com>
Date: Wed, 26 Jun 2024 09:43:11 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] netdev: reuse
 NETDEV_EVENT_{AUTHENTICATING,ASSOCIATING}
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240625130624.385553-1-prestwoj@gmail.com>
 <20240625130624.385553-3-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240625130624.385553-3-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 6/25/24 8:06 AM, James Prestwood wrote:
> The authenticating event was not used anymore and the associating
> event use was questionable (after the CMD_CONNECT callback).
> 
> No other modules actually utilize these events but they are useful
> for autotests. Move these events around to map 1:1 when the kernel
> sends the auth/assoc events.

So I went ahead and applied all of these since these events weren't really used. 
  One thing to keep in mind is that the ASSOCIATE event firing in 
netdev_driver_connected was to take care of full-mac hardware that doesn't send 
authenticate / associate events over NL80211.  I think at some point this was 
used as a hint for something, even on full mac cards, but isn't any more.

> ---
>   src/netdev.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 

Regards,
-Denis

