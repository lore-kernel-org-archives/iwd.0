Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF7817E9
	for <iwd@lists.linux.dev>; Sat, 27 Jul 2024 15:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722095267; cv=none; b=Ha/VJukJVtEALvLK6AwdEM2Q4BtrRAbdGqswM7Ti5N7m6EICO3RAWD+5UnGQ+UXNVKk0HtL70rrc3AXkBXPNXMc2HhtdOGb0FASTSA/TL1rXNzxJqx+R/ORg0ZWrVL9yJbjA7d81ghvsW8jPvLF3QSRTBaikeeG/mNDN3h44zxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722095267; c=relaxed/simple;
	bh=np2tnXcMAbZ6Wnan9WbFUii9sJH0RZ8ZcznfHBYULVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GbJqMlpl3x58X6CzVQV0XDsdoNBXgkkBAyQ6POtw0EEsykLmJzEhPTH4kOGXz0mOeX96pihEcpVsM98hqdb7kw4eqYb8XVNfWmklSQbeRLUjED6Y4Iyjq1ZSAKYg1F8x1DVwLS1xNoTfd5OV0NnlXQEhvMnrHLvTebvHdrvza80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9g5IFJ/; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9g5IFJ/"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5d5c7f24382so962586eaf.2
        for <iwd@lists.linux.dev>; Sat, 27 Jul 2024 08:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722095265; x=1722700065; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S233fuaPduE3WQM0Vs1ZeYASZcGtrBCOtiKPiytNJFE=;
        b=k9g5IFJ/aawXarBqRBJx/0zehBFYI59FPQGUvpC+GVU1t1XRjZYON22iTWg01qI3bX
         SCOWivvlGNDsiOZu63eZiSeAK++WfCFMkKu1GTsyfKToOMo5Awvo94tpRbu9pTCH4rnd
         qezjJ4CJ+R42CMTmTWh+x6rjcudrTwPWsdB4bwALlZSo8PCGJ8vEmzD8ATGAZO6Th26G
         KbSrjD0eRdKhuzE0q/e37ZIk3aXK6Ab5qnHZfeohzZKcjqeWg+fK8b19690G8mFU1pCd
         42HpAtplw51emSjb+MHaxAZ7GI3KfnJllxSct1V9keTmPPkzyeFt2H7suTp1ZFOXz/Bv
         XuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722095265; x=1722700065;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S233fuaPduE3WQM0Vs1ZeYASZcGtrBCOtiKPiytNJFE=;
        b=GL0uLQQZDvoQlgVMqoK4BwgQtOJiL48sPewq7u6mtjz00cnoG7iyVXiA5b+IX9qSri
         okKw4H2Hbtv9mPBUmQYYhvY4hP6drrMqR0yLOBLFSfetVmIWDQxlRGMXMLGq4ykK71r2
         344UL5JLXUQJCsYoKZCC4Z3HomAG1tYJplwv50ah97mf9yTK8upnh1/6pjQAV89P1Cze
         IO82sQ7Rmp8ORNG0QQGlJTgIWb+O/BcSHjBI5DNkrOscj5TekFDIaXTDiSLk36mSgnHh
         2DJlqUMcc9M7CNpAvHbNc+Q9dzf6t6KLDIA7/LMwzX4sQSI7pO82tlEO8Ce7HeG3YIaZ
         m5GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE03hFJrW2jN16Yyt4rbLxEiK2cLOsxC0MQk3mfPSjvzCMFs6cqW3McGO0MKPiFchOfRpjjzgXwXu2sMWm/RL09uOL
X-Gm-Message-State: AOJu0YxaFtHnfp5BgATtdRZ1vlUoym6uIqvQVldIlJKiHrjhXJhzgJOU
	b0vWJbJtVC6YoCZR4RfraiiqkMsrUHE588qdB/J6E5KlLIpDms8g
X-Google-Smtp-Source: AGHT+IEZqEiwiRIuDmrDQ/JNMwTwEPPYmqJYo8U7Zk7We6lULTu23V7pEk2B1eN6AzbTs0FI9Ukkxg==
X-Received: by 2002:a05:6820:50c:b0:5c4:a84:3ced with SMTP id 006d021491bc7-5d5d0d86e1amr3439370eaf.1.1722095265245;
        Sat, 27 Jul 2024 08:47:45 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-5d5b35e7fbfsm723904eaf.27.2024.07.27.08.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jul 2024 08:47:44 -0700 (PDT)
Message-ID: <5ecaa615-2aa5-4594-bb67-a400a7e957b7@gmail.com>
Date: Sat, 27 Jul 2024 10:47:43 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: compilation error in iwd with ell commint
 883bc6a90b4a9c654fdf2540f02447a7ca567e04
To: daniel antoine <univac55@gmail.com>, iwd@lists.linux.dev,
 James Prestwood <prestwoj@gmail.com>
References: <CA+iibzC0yNsPu3chJj-aRA6=7Yyur_sspoKtO_SpjqA4xPsgGQ@mail.gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CA+iibzC0yNsPu3chJj-aRA6=7Yyur_sspoKtO_SpjqA4xPsgGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel,

On 7/27/24 7:25 AM, daniel antoine wrote:
> Hi James Hi Denis
> 
> I compile iwd with ell include in the same Pkgfile
> 

Applying the following patchset should fix it:

https://patchwork.kernel.org/project/iwd/list/?series=874190

I should have held off the ell push until Monday.  Oh well.

Regards,
-Denis
