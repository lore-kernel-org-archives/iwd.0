Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2CF4D105
	for <iwd@lists.linux.dev>; Fri,  1 Dec 2023 16:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9vprLb9"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-58d3c5126e9so1278394eaf.1
        for <iwd@lists.linux.dev>; Fri, 01 Dec 2023 08:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701448223; x=1702053023; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y3KXiwHP4GoUe3bntyCBxbUVBEFVMKDoLpQrHnbDNt0=;
        b=f9vprLb9hybUgY5kaR8x3asfUDzZBk0D0AFXR6J6ycc8duxA1nIAcaJ6uWNB0mI82t
         TJcQaXfnJfoVQUcjG205pZEpEmBFKBuBsE4OvGClTHhZNZHRS6hFJ4tVB3qUOZ4ljlgX
         b8Y2L04cqh23VU1qmlRYg+dz5c8YIWXcPyTzKq7KkLI2EDlIkIJ1uBkZyn1xzW6emInz
         4PfY8LF8h2/F2Zki29brb0BlMePN6pq1mPAtvQ8bow6DYvElmFZ84aIaeNLnwaECNOtm
         yFDEAw3osO7kpA8aXtS/tBu8c0lZiUrI6SzMtzJe+4IaIdiU0VDss5ZDWxnp1WZiEuRg
         UQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701448223; x=1702053023;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y3KXiwHP4GoUe3bntyCBxbUVBEFVMKDoLpQrHnbDNt0=;
        b=mzibyjcni1us9Gzk5WzQPxQIXEeAHz050pK+Du51kiBhUuY5LoFZlSLYiXJ5AJC5kN
         UbvZ/KQA3PlaoZfuzfYzZn4NFssWMp9WCUKuPk7pERBFKmSts3C2loYZ0RnjDhrcEw22
         lqbAj9TcvSHj30QaqocGoJhla/ML6qeZNhQFxnfTXz8oBkq32AvA8Q2ivCaJxZLyWoMK
         t6LC8oc/a7Dek3FpAdhcA3kj/bDC1M6irgV6pQHR1Y4fOCFT95s2oWeCcEJIxb71FpNS
         RRw3TMb0xNkWc45QDjH7eJ8pX5XaJj9CakCccIuQWyITkzYrZzWpjOQkFKjRMeXyVGgd
         GPsg==
X-Gm-Message-State: AOJu0YxIEyQ4YjGL4RPSagoBxzoCqjK1uwukg1ZG9NfqTDurkh54GJch
	WIAwZOTO1SjL52S/5Z5g33MMfpWavC0=
X-Google-Smtp-Source: AGHT+IE/Qyy1Ytb+NGrUTRlniA8yME4P7xN3hycWttJz1JEIEkhERSettgrKYc4PyeVDE+CilGconA==
X-Received: by 2002:a05:6820:1ac9:b0:58d:c5c5:c0e with SMTP id bu9-20020a0568201ac900b0058dc5c50c0emr3856656oob.0.1701448223629;
        Fri, 01 Dec 2023 08:30:23 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id y17-20020a4a6511000000b0054f85f67f31sm624982ooc.46.2023.12.01.08.30.23
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 08:30:23 -0800 (PST)
Message-ID: <de644b92-b897-432a-b6de-a8ca595026bf@gmail.com>
Date: Fri, 1 Dec 2023 10:30:22 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] handshake: Add cleanup function for handshake_state
Content-Language: en-US
To: iwd@lists.linux.dev
References: <20231201040020.161143-1-denkenz@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231201040020.161143-1-denkenz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/30/23 22:00, Denis Kenzior wrote:
> To allow _auto_(handshake_state_free) variables to be used.
> ---
>   src/handshake.c | 7 ++++++-
>   src/handshake.h | 3 +++
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 

Applied.

