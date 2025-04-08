Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD39A1CF8B
	for <iwd@lists.linux.dev>; Tue,  8 Apr 2025 02:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744077832; cv=none; b=PvyhyV+F99JFjC+uvHh7PcfLqUZYWbtgdGPmZ13SFO3Rsg0w0MizfgR0BLStxvquQz+q0x4JLGs6gaYajv5MiTubxH1334bkm2csS/8Qdc/ItzKxjBxclB38EW2W/BH99HDQmZ5cb4yvw3APdQsR0V25PYLv5EVxW/lV2UePbZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744077832; c=relaxed/simple;
	bh=387c9R9aFInLe76C+zHjM/OQVyGHhCqt8mJB4cA/prs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WB+7SCX6KCn4UKaMDFcMD9JJiDwYBX976Bn2vmHwShL/XvcqK+70x1F4s84SnPEOVflFXRBA6X4VDoLGchXUID4IH3IV1KK0rnpeTLxh8PRLW0wgv+v446igPE76lVvLA4Bvly1MmEhas3/vWa9S917LhkQUzdR5ZEY9fuJFaAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckFN8W9q; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckFN8W9q"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-60402c94319so2498224eaf.1
        for <iwd@lists.linux.dev>; Mon, 07 Apr 2025 19:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744077830; x=1744682630; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=15qUWLtgkgbOk/yScp5NmzuiCbb1NIZgQ6GG62ANdRA=;
        b=ckFN8W9qGjtVwflwFLEjL+UetrOD/gb1kuaHjlkThwpf+GVHckGFGomGmzf07szCdF
         pNAPVqqmJwvCrN8GIi0FCuYmFpPYtbS5zGhcPsiPuuXvugseWq5Us0rWtuTqNrnE35Hx
         i7+bM/JkqBb467yMg6+PpjhJGnN1iHQiNJyAoIwsSptWu+Af/dBGQh37DKGDfnn5Czc2
         5LzkxwKdvBsfFicZMYHBim/mLQWfsrk6w1FR2FlT//xIqPo1/lMby54Aldntt0MSNyFQ
         X/ZLxzIqqEBLCPnb3fvPcYCOlpwm7zWJmVdBXbylT3CGmZrgZ5I1MgfV4gi75iefCEZa
         CQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744077830; x=1744682630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=15qUWLtgkgbOk/yScp5NmzuiCbb1NIZgQ6GG62ANdRA=;
        b=IGxpaR7b/4qpb+PHfYJ5bv+L8XUGZDedVGMERxripJYfEpaMRICJbCN/jyAp8q8Y/U
         37O6z9NevVwt5kR6olODZrPNFpT2mTLIjV5avlYtNErSRfsIpS4nzVfuq2absD5cREo/
         yYnYbeRbURHgP8SKX3zhnIXTOsJNqPbz+RXt4k7dqX4v1xvS5A7jGgpexYCB/6xroiWm
         LBDjvL8Tw+nkoKkyTDoBFzESMTMnII95NQnRsTrntmnOF/7ARJ0msBPnsPuLlHgIkd5z
         HNg1AyRE8umniAupqn9VqBR7w3QJ8wNL1Bk3hYExFpkjHWJuZlnwG0Kg/5ulSu0gSt+9
         ffUw==
X-Gm-Message-State: AOJu0YweCOmenoPYurMrH9RNY8JZHQ731UrU45YNxbsv0ao3bRPssaO4
	Ua85/i7D818uSpmZpe3hbSdmVI7Pftqb6U67h9nkUs3uhdgLwjZ2
X-Gm-Gg: ASbGncv8F6GjIse3kEUZyRfptdNPD8ETAnJxWn3Hwifhh9wAgY5XRFooQnjzPqjeoBo
	n/q/fVk23nV1WE9ofqC+OVnbHmdn9fU65zJIxMQzp25VqkeLG5Tkx+OW4kd0SVx7qR/lLwoLEmC
	p8o40EzOFsrya+Go5ks8XnnCY1NcUrgQieL/YQP1fhb9XEyNxReEqIbloIJhldUlxQB7xSH7byc
	/MbeBT71e1PRh5ZpAhdMAn+qWKaD/gvw38QhCNkXtDv/lbHJzkbKO10TMWcyO+Mc+XiJ8hiD7xL
	iRUcdkomNsD/oEqycAHjKc1RD7d0sYszxph18DxoskWna7IZ9iMSXMWZUdozmGKXaz5z9SClcM3
	DTMvpU/5szg==
X-Google-Smtp-Source: AGHT+IE0vTcEX0KevHn5NQnQGYpA3N743RaqDgXH/2mc/MuHxHRchS4WkNhhqsV3UueXShUMEVvAHw==
X-Received: by 2002:a05:6820:1890:b0:602:584f:547a with SMTP id 006d021491bc7-604156fbaeemr7815896eaf.5.1744077829740;
        Mon, 07 Apr 2025 19:03:49 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-6044f4bf6b0sm209109eaf.19.2025.04.07.19.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 19:03:49 -0700 (PDT)
Message-ID: <27237ccf-edbe-4a1f-a39c-6070e4a7e821@gmail.com>
Date: Mon, 7 Apr 2025 21:03:48 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: strange behavior with synthetic ap0
To: KeithG <ys3al35l@gmail.com>
Cc: iwd@lists.linux.dev
References: <CAG17S_Mgb9fHFcwW1KoNZ2QxZVH2rKZuwG5i78c8us0HjwO7Eg@mail.gmail.com>
 <f436a083-5e70-46f3-841d-c59c10c6adf0@gmail.com>
 <CAG17S_N=DnnnLY+hGiqQCfopr1ZngCW0T4_H0+yyP9Z8DiqzhQ@mail.gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAG17S_N=DnnnLY+hGiqQCfopr1ZngCW0T4_H0+yyP9Z8DiqzhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Keith,

What does:
iw phy | grep -3 'interface combinations'
say?

Typical WiFi chips support only a single channel (e.g. #channels <= 1)

 >
> How do I ensure it is on the same frequency? I would think that I
> would have to change the freq to whatever the freq of the SSID I am
> connecting to. The process would then have to be: query the SSID for a
> freq then stop and restart the AP... Wouldn't this disconnect the AP0
> from whatever is connected to it?

There should be a way to tell the AP to switch the current channel.  The AP will 
inform clients about the channel switch and they should end up at the new 
frequency without losing connectivity.

> 
> A bit oif background, I am trying to write a python script to do a bit
> of magic. We use connman as the front end and iwd as the wifi
> controller and there is no real good way to have this headless,
> embedded device always allow a connection, so I am trying to get a
> python script to monitor dbus and when it looses its wlan0 connection
> to start ap0 and allow a connection that way unless it 'sees' an SSID
> it already recognizes. In that case, I am having is down the ap0 then
> connect to the SSID on wlan0. That works, but it must be serial: shut
> down ap0 before connecting to SSID on wlan0 or it complains that the
> password is bad.
> 
> I may be mistaken, but I think that a year or so ago (kernel 5.x or
> 6.1) it used to actually allow both simultaneously.

Different firmware?

> 
> I built a kernel last night so that I nave nlmon available to query
> what is being passed if that is needed.
> 

I doubt nlmon will show anything useful.  You'd need to have information about 
how the firmware / kernel driver works and any constraints.

Regards,
-Denis
