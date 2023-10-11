Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B1133C0
	for <iwd@lists.linux.dev>; Wed, 11 Oct 2023 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRHsT8zr"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3ae65e8eb45so4796364b6e.1
        for <iwd@lists.linux.dev>; Wed, 11 Oct 2023 08:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697037848; x=1697642648; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eawZm7MU/z3EF7zMnwN8grFH0ewPiJig55sWlcJslc4=;
        b=ZRHsT8zrR4DYRA7tRhEE3e2FDJKJJUYuUkXhBoCOIjP9O+o+l11MZ2RcG2E+VBDiAE
         kdH0wDu3Dqc5wxjypjpsMAr9SScsPBYgrmpoMI2X3J4bTV0wqnQ6GAGA2mXdQiLdlviT
         Tlm2FiBPEUD7gYYdNf3CjXxeHuMny1xFjIf5xGjZytwgYZdgQCsNAqUGZalSlzg/aQq6
         JgEeM4PK8B/ffq1JHKCztLJR9Zz+xi1SgjK4GdO+t2ZJ2IZsqW5AP/i7+wR7YuxQof2H
         YQZp37G3WIXmFtJHmRQk+dDdFhvJ92GjADzWvZmy6RmZGYXCQ8DpprWd3IibI83C58ri
         onMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697037848; x=1697642648;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eawZm7MU/z3EF7zMnwN8grFH0ewPiJig55sWlcJslc4=;
        b=uU2mydkpXdThTslFF96aa8BYylXesb9pVqDdUggx0eQAY2wgiquIBY4zp+REqT7g2v
         O3iFuteuSaoOuNjqb6Q6NIJISgY3poAeY8pRXNmBPyxLN3nTS033m/cZvCcKHWV1ogzb
         Ht4SG0Z3Ncd4eJqK/NsHOBe3dM5KngdplDF4nayQbUodt3Gcs2pobbN4PkJUcC0UojKM
         2JmZf933QvdIjmYhMYrI2Wd40CpcFftl3r6/F1ZkLB9258nTclXUxHM8HAM9m4HRyONJ
         TXwpmnnT/O2ijIngcKM0MLQCXAi7rNpBunzKl7mmGohj99pjRR5fS3EHaBK5dd5rHqgd
         0mKg==
X-Gm-Message-State: AOJu0YydcugGsq+fIDiJcn6lIEmjYTz5NUKiouNGnYksyWQx1q4hipyN
	PJXH41tphAzPVMtyEZgsM/w=
X-Google-Smtp-Source: AGHT+IF8CB0wGFLVql6s2OhG5kmx5JHzsKJHGjzxp79EJJ3Yw/xTeAxS7Wk0uSEpvXcdejxmXvTq3w==
X-Received: by 2002:a05:6808:f8c:b0:3a4:225f:a15b with SMTP id o12-20020a0568080f8c00b003a4225fa15bmr26898617oiw.31.1697037848626;
        Wed, 11 Oct 2023 08:24:08 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id s8-20020a05680810c800b003a9a2362f66sm164ois.16.2023.10.11.08.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 08:24:08 -0700 (PDT)
Message-ID: <00639fc2-662c-4641-89c7-7696d88b610b@gmail.com>
Date: Wed, 11 Oct 2023 10:24:07 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] unit: add to test-dpp to expose ASN1 point conversion
 bug
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231010135704.198723-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231010135704.198723-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/10/23 08:57, James Prestwood wrote:
> Add a test to show the incorrect ASN1 conversion to and from points.
> This was due to the check if Y is odd/even being inverted which
> incorrectly prefixes the X coordinate with the wrong byte.
> 
> The test itself was not fully correct because it was using compliant
> points rather than full points, and the spec contains the entire
> Y coordinate so the full point should be used.
> 
> This patch also adds ASN1 conversions to validate that
> dpp_point_from_asn1 and dpp_point_to_asn1 work properly.
> ---
>   unit/test-dpp.c | 44 +++++++++++++++++++++++++++++++-------------
>   1 file changed, 31 insertions(+), 13 deletions(-)
> 

All applied, thanks.

Regards,
-Denis

