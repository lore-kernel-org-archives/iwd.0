Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373BE2B9B5
	for <iwd@lists.linux.dev>; Fri,  1 Mar 2024 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709304144; cv=none; b=qYYbf1SmyKMEFO+kpfY2jvQQD20Aq8g6FX4yLAjPn7u5a7RLIRa69xSjTzzC8afYSiBUj1uFsZT7IHozh01XB3/UFW1857TzLWRC6ShsT1ny7kbpbhPnMKavJwSwdi3K/i0L4HsHDmPrUopmOOchd0U3voIazpqEw+4s5uIyy0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709304144; c=relaxed/simple;
	bh=GHzvCJOtLpdfPYFJLnTzGMMMZO9bUCwl2A8EozaV9qA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OuvMfULM9gCNV8iJCNgJ86igSKvwctYGnzcnPXjoZYUJQ0XXj954mNfmantovrudFPE7XInjye96D9iyt1uC2kyhS0WNMLQDjlWyO+Q3yKMFxjG030tKHcVsCYX2MaB8UaDp4pXj2ld+4CuePa2s/24dGQgA6QnJjej2RZSbUI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4iTFDSm; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4iTFDSm"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e4899fa7f1so1049541a34.0
        for <iwd@lists.linux.dev>; Fri, 01 Mar 2024 06:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709304142; x=1709908942; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LAdeDeHXEopo6gtMbb+aOYL6x6groqlj6NZl1pYfmzI=;
        b=m4iTFDSme6c+lMwRcDCMo/wPwqnIufoEbsa3cE/73iQs3B6m/GCofdE3lVD+3Uvg7G
         fGfrA2XkrOHDy/YwSL601rHKmct35v4bXkcKfhzgAE056xFywhoNdyJ/rMid43bcK0yY
         3t3hc4SeU4TQT5pZclGjbk+SllVlTh2hLOMN9QMinqbEKPkd30z78/Cp5tDncZJs8ZIF
         SJrUCYyFVN/tbSKHZrpG3ECCWJBch2JmEtSEV1YzW8LMVljXIaC1O7xFHJ9B1ZVKrkHY
         jXZk7AkubXPz4x45j/z47lfOfHznKJnpRI/u3dc7tdAE5daLI33fqNbrRtbLFsGHjarS
         r4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709304142; x=1709908942;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LAdeDeHXEopo6gtMbb+aOYL6x6groqlj6NZl1pYfmzI=;
        b=Dk14geYL7P+fgNFHQFIYzDLZU0XApm/QEvU+jym0erJE/KhQok/osLK99oOxRPmnP5
         kCAcCMuKXj9Mk9Goc902ArVMLowdtJTB5aVpfTyffAZ2k+XSrSX1u2OXlN2sI0Xb6vBK
         iAoJdsnzFOFl5Pojr/S8pewkq9eMKkRLPQj6/U5cEzhTTVHL5uymExnFMkVgqwT3/Bw7
         jeSnImgp96phK4QubnPw15qR2+7oIG+oH5kH7qO/dauKrPaqhjQRJhrFf+gYuGX1+eTF
         l8UWllHR8NPdTBaQBdzzVWXncWiZ5Fx1+c/GzSJcQURJDuj4FbYOyOb4UgLXYoLnb1bR
         vWnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrmQD0LHAG4DL3wIWETAM0TIbAyXnqJhktGZ9xsnOAbB0X2eV982NeH+42+JeHKN2+QPY/l/MSwStcxEoGMwxwWiMS
X-Gm-Message-State: AOJu0Yw2dUR9/ZdHGq3rfasBu9j4/8G/7wXg1TpHJnNrfQeR0nJRCeAA
	KeP0sXCxpWHpkPLx0VPCWfLouHERSDxz/b9c2siOy+p5jxQVkqjl
X-Google-Smtp-Source: AGHT+IFMMjhrJ69Rpp2iKY82eiD343A1sCrtJyWLXhQDIJ5dr/jINV3g/JoTstg7y8cbn3SE6Vm4tA==
X-Received: by 2002:a05:6870:a92a:b0:21f:dc81:1c1a with SMTP id eq42-20020a056870a92a00b0021fdc811c1amr1725953oab.16.1709304142295;
        Fri, 01 Mar 2024 06:42:22 -0800 (PST)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id rd5-20020a056871620500b0021edb0e2091sm1055983oab.15.2024.03.01.06.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 06:42:22 -0800 (PST)
Message-ID: <d4c6cccc-2391-4dc7-a085-2efd242128af@gmail.com>
Date: Fri, 1 Mar 2024 08:42:21 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] auto-t: add ability to reserve radios not for
 IWD/hostapd/etc
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240228174743.1237719-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240228174743.1237719-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 2/28/24 11:47, James Prestwood wrote:
> If the test needs to do something very specific it may be useful to
> prevent IWD from managing all the radios. This can now be done
> by setting a "reserve" option in the radio settings. The value of
> this should be something other than iwd, hostapd, or wpa_supplicant.
> 
> For example:
> 
> [rad1]
> reserve=false
> ---
>   tools/run-tests | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

