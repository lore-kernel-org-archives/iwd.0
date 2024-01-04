Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD5228DD0
	for <iwd@lists.linux.dev>; Thu,  4 Jan 2024 18:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGxd+i7i"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-595d24ad466so345473eaf.0
        for <iwd@lists.linux.dev>; Thu, 04 Jan 2024 10:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704392306; x=1704997106; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ULgvXvmQCNlq+TGZlQVWvhmhILNihqwxOeMDCKFMoqA=;
        b=JGxd+i7iyrXDtXOiViwe9N90CR01jmDPMg4oBrkaJVRjyhBVaahzthjO+Gm/EQipRl
         PVp4rM5rbA3qy89oD+l8lbiWvw00a9YYrRfPovw5ineL/tv/d1I1V5r4+Af+LvGHuWH2
         iAew/JZmDTx8SVX6CJZ0zIFIYy/uyGiD5075y33JyHw0x8Xqz/ikiGZmlypzOqGEOcGu
         SqKOr06JjrvUfL1E000bkqEXNTIWHcRPfR5kApIGzA35YT7IMjZhN/KFmQi9Eco1qE4a
         5+NIOcGOlQ50mXlF8s+lbO+98JTtMJd6VSuuLT+x5vwRkhlVHMjCG8cfLWRZvz7RPhgJ
         rq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704392306; x=1704997106;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ULgvXvmQCNlq+TGZlQVWvhmhILNihqwxOeMDCKFMoqA=;
        b=roAKM5XEAETVLXxvYLLqkBbLRhLLW7XLYlr1LsGY31jH98xljMXWvSgFkfXZDLvZRn
         Z7H2hOaAlIauvQK8Kbne4ak2MJDCe7k9V1mYtHc72uZbn+phjv6vpcpLXRKNPQtQZlnv
         0F61AcW/B5JTGPKwhzX9H4qss82ThKefqwn2kPDuyozh16/I1LWk4Y9P99Mpl2WCdG8l
         NF0IbdGIcGFPi3QK79m8cSwDsQ1nkTBXiFsPk0pO/wfGZE3lYHR/FCZ8/onXnr/89jPi
         BX7aT0hotsx9ny+nePYQC0aj6EnFT33oQrEtt5I8D4ChUZMHUc8W0vy4OMF1q9AK+moB
         n/CA==
X-Gm-Message-State: AOJu0YwmjUJBz2MSGJYJtXWfrawLEzWx1fzcbjVbxSfR5pK3sS6LC/W3
	26m8eF1VPrQ3WZeksQnkhP4=
X-Google-Smtp-Source: AGHT+IHMQPppJTY/vF2zByJrZ4iJ9qrAnRLvE7YRNwW9xCJHs0yN/x8dlED9Q2nSLzUnmUNFTeAwDA==
X-Received: by 2002:a4a:4ec3:0:b0:591:8f93:67a8 with SMTP id r186-20020a4a4ec3000000b005918f9367a8mr1082438ooa.0.1704392306412;
        Thu, 04 Jan 2024 10:18:26 -0800 (PST)
Received: from [172.16.49.130] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id o185-20020a4a44c2000000b005954c783f46sm2188877ooa.20.2024.01.04.10.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 10:18:26 -0800 (PST)
Message-ID: <42e1801d-6845-44da-a4ef-6b8c41d596ec@gmail.com>
Date: Thu, 4 Jan 2024 12:18:25 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] monitor: include unistd.h in main.c
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240104125826.599998-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240104125826.599998-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

On 1/4/24 06:58, James Prestwood wrote:
> This fixes a build break on some systems, specifically the
> raspberry Pi 3 (ARM):
> 
> monitor/main.c: In function ‘open_packet’:
> monitor/main.c:176:3: error: implicit declaration of function ‘close’; did you mean ‘pclose’? [-Werror=implicit-function-declaration]
>    176 |   close(fd);
>        |   ^~~~~
>        |   pclose
> ---
>   monitor/main.c | 1 +
>   1 file changed, 1 insertion(+)
> 

Applied, thanks.

Regards,
-Denis

