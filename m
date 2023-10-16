Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CB11F61D
	for <iwd@lists.linux.dev>; Mon, 16 Oct 2023 18:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQMjA+sp"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-57ba5f05395so2971132eaf.1
        for <iwd@lists.linux.dev>; Mon, 16 Oct 2023 11:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697480481; x=1698085281; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I1OStHQ5Z+2HpZCZtWbxkwxjJWfE9UlM3zstUHvwaKw=;
        b=RQMjA+spDObf955dLX4T/5UJD0bI1c3B3wcxX4y/33I8jZB0esRQpkZF6wX3fWcK+R
         33vwys5JxTVtgVjPjj+/1/IsCdHx9TAuECVzJdsJzbc/VIwalsmrWbAAJP4DDmEdEUN9
         creLIEMbz+CymWQ7G62fUY1ZO6qkFvqh/CaRPhbst6fsBY0bHkNzqVgxTSxEZUbH1fLk
         TdCzoxQ6ktkiwcobp7GvWPcjJKKpS79R9g3MXqWJUUwE+mnNplvuhbNDul8Zzm1Q2TTH
         TCDfqNwiNIWycBsLQwkSd3uSQVEEr/axDQv+pVNT8ZLBLKMCNtnHu3HagYm95R8yHz8d
         ZRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480481; x=1698085281;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I1OStHQ5Z+2HpZCZtWbxkwxjJWfE9UlM3zstUHvwaKw=;
        b=ehUm1doBm13QPVBP1olcgmLpxCBsbIYExfIka1U2MfZIQXHjy9XPBXcmaWm3n/Lnol
         bpGCm5nmCyT/RFz93uLTmR6hk74djpewuVR3RWnBsfHsVIisoLx8iFLFjfa4uQuWv/fF
         kP0vAyl1MWJGWGS/bcQPizqB6kS+x+DkKRK7+kPzMPDtg6aFAN5N2bkYUR96MlUzY8t8
         T7fRAlqkbo/RZRzOy3B+hVZ0d+Vf87LldxFNZMk2bCzCzWv+YromuAUxRgOVSv/w+bQF
         9jvKDZWH80hYM5Q5FWSEWKJDv1uWaCP2aE19+PVNjBWT7EXU/R9i+oaJUlR7PTicB5uZ
         beWA==
X-Gm-Message-State: AOJu0YzRirvvDT2YqSWlssPU2IAkxCA7nbT9WtlAwJdMkn9A4xa/6Kd5
	2JiVSfKaW1MEwPwJ/v7RlWE=
X-Google-Smtp-Source: AGHT+IEyGcExAm54rXb4ZpnXyr2eJGiEBW+VO6fefpvRmM0OfawWAiET2ZNpjDdJrdA1LoA+u9Oz2g==
X-Received: by 2002:a4a:3009:0:b0:57b:92f2:1f64 with SMTP id q9-20020a4a3009000000b0057b92f21f64mr36688345oof.8.1697480481028;
        Mon, 16 Oct 2023 11:21:21 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id g18-20020a4ad312000000b00569c240e398sm1167241oos.30.2023.10.16.11.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 11:21:19 -0700 (PDT)
Message-ID: <e2bad492-31a0-4c92-b03f-beba292987fd@gmail.com>
Date: Mon, 16 Oct 2023 13:21:14 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test: log correct function name
Content-Language: en-US
To: Sertonix <sertonix@posteo.net>, iwd@lists.linux.dev
References: <CVMUXBOJCCQ3.3DY5I2CD7ES6U@sert-surfa-alpine>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CVMUXBOJCCQ3.3DY5I2CD7ES6U@sert-surfa-alpine>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sertonix,

On 9/19/23 06:51, Sertonix wrote:
> Matched the printed function name with the actuall function name.
> 
> The simple-agent test prints the function name to allow easier debugging.
> 
> One name was not set currectly (most likely through copy pasting).
> 
> ---
>   test/simple-agent | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Regards,
-Denis

