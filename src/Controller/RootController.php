<?php

declare(strict_types=1);

namespace App\Controller;

use Symfony\Component\HttpFoundation\JsonResponse;

class RootController
{
    public function get(): JsonResponse
    {
        for ($i = 0; $i < 16; $i++) {
            \sleep(1);
        }

        return new JsonResponse();
    }
}
