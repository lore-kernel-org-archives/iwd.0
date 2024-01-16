Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207D41CA9B
	for <iwd@lists.linux.dev>; Tue, 16 Jan 2024 17:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705425318; cv=none; b=uSBHS56FO/ENTp1kmEXJxO+sxZBoAHVY6enja3CUm52w+5B829x3t9iaKMlSXJm2hPp7D0GNVRJ7zKwkCyc6gClNJOYEQnPFMpTYD2sZqhXJCqbIWgqnHAySt8+d2O9zwkiEM99bn2kb+niBjkOUbjK9eKsly4SGpJs8CTfYV04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705425318; c=relaxed/simple;
	bh=Pj6ynSzR/+oCszC6nsOyXQP3h9XMhWZ1JWEe+qYxFzI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=T0NgpnlrCS2bjr7UW6sPb9lvKndhziKEo1oFiGPtBx+eH+4ADM16Ydu1ofgZfJqVt0lcrsksoRb1GBjxojShPatNgLZo8I4RjeBl3WDgeDlqeQDVSWWgycXSKk59nK4IdHHYWFPGRJctHtBiR6Q4VbdrjVVAZRAfszt0oGoLgJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6r3f5dB; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6r3f5dB"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6817505b188so3184256d6.3
        for <iwd@lists.linux.dev>; Tue, 16 Jan 2024 09:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705425316; x=1706030116; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mlS4V/Jryom9z8yPaViQK3BCaNi7spbscW91996j0jU=;
        b=b6r3f5dBnGMHXWA9U8XwHhiuQYvn9WW5ek95SczKKXJdo5Di/jvFzdU7zTkgc9+4aq
         kYyVqJwbBGD8ytKtlc1CZtE7YY4ESuKo3911hbA0IZXUKclksbz6iWQZNI85ftCmajcg
         W7vcvZXHZ3UuoW4MI/Vvu24G1VmgKi41kQTQh0dwWJ85Usz6nrnM8h06xKX+ShU90DNR
         jrqJKfPj/h0qWDKkoeX+bP+oVQ+RV66MIVOrrEFEdvA748swJD3qOWatk96o4uKzSUqL
         jSeem9rDSGSWD0ortMKNa/q+yJprrA1+v7SQNC0v9Z5CkeBUROO7C368g6dadnVQYrBF
         4Ozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705425316; x=1706030116;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mlS4V/Jryom9z8yPaViQK3BCaNi7spbscW91996j0jU=;
        b=RwMmSWeITszo5Ae6qGZThVcL1Rtukf6m5+dlF1wzlSiSr4xA5lOIFmfgq+P9WAgio/
         jp3QolSdQlA1tCv5TOkoxnHydPgqZ7qojMumbWzHAkA54HYMMa7uD1I2qZPbszBV0cPU
         y9sIv9/ucsYy4JI1o4hKLKzLFComTkHeDoSkIXeJIjDI2Zp1HC7EHlkZULT6UvfoT6YK
         QZBbGTAV0Rw8oY0tD46poKB7eUNREFwcrxkjPqCUVd/Niu6basIFP2/O7wHJNIn0cNgm
         QvrGENVEILnvN2k5/uBRvF8oDu5+3GDQoBY+V9UnudGC4V1vSo3JZwMXcaZ7unfI7qji
         mY/w==
X-Gm-Message-State: AOJu0YzK0Q3pljEwrQfgqRFvEkYObMQc2Piy/27e/Wjz1g5H/T1IUAVS
	zkMjUdCiY2fEFKx1i6xJKwk=
X-Google-Smtp-Source: AGHT+IGNymS8ZleJCyWvEd8aGWAfTVl4enLWY/glcx65uyHa1qzoOlVUS1RhkrQjsItmEiGK7OygYw==
X-Received: by 2002:a0c:e3c5:0:b0:681:557a:84a3 with SMTP id e5-20020a0ce3c5000000b00681557a84a3mr5440952qvl.119.1705425316020;
        Tue, 16 Jan 2024 09:15:16 -0800 (PST)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id v20-20020ad448d4000000b006817069492bsm620658qvx.70.2024.01.16.09.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 09:15:15 -0800 (PST)
Message-ID: <e3e82ef7-941c-4dbb-9f1b-2d1579a12f74@gmail.com>
Date: Tue, 16 Jan 2024 09:15:13 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to Autoconnect Two WiFi Cards?
Content-Language: en-US
To: Fabian Herb <fabian.herb@xtonomy.ai>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <DFBE16E1-468A-4292-9056-D7ED6AA0CB4E@xtonomy.ai>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <DFBE16E1-468A-4292-9056-D7ED6AA0CB4E@xtonomy.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Fabian,

On 1/16/24 8:48 AM, Fabian Herb wrote:
> Dear iwd users and developers,
>
> I have a setup with two identical Intel AX210 WiFi cards. I want to connect each to a different SSID. Automatically if possible. But I can’t figure out a way to do that. Even if I connect each one to their network manually, the next time the signal is lost and a card reconnects, there is a good chance that it connects to the wrong network again.
>
> There is no option in the network configuration files to limit a network to a certain interface as far as I can see. I also tried running two instances of iwd, each with a different „—phys“ parameter and STATE_DIRECTORY variable. But the second instance fails with „Name request failed“ (something D-Bus-related?). I also can’t see a way to tell iwctl to which iwd instance to connect to. I also tried using NetworkManager to control iwd, but that worked even worse.
>
> So how can I force each WiFi card on a different SSID? One of the SSIDs is on 2.4 GHz and the other is on 5 GHz. Does that help somehow?

You can't easily force this in general. IWD doesn't have any 
user-configurable network priority, it just picks the "best" network. 
Nor does it have per-phy network profiles which is really what you want 
here.

Without implementing a new feature with per-phy profiles about the only 
thing you could do would be:

  - Create a network namespace (e.g. ns0)

  - Move one of the phys into ns0

  - Start dbus in ns0

  - Start IWD in ns0 (specifying a different state and/or config directory)

And you'd of course have to deal with the routing to actually get 
traffic passed between namespaces and your host.

What exactly are you trying to accomplish by connecting to separate SSID's?

Thanks,

James

>
> Thanks in advance!
> Fabian
