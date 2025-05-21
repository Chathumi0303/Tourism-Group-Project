package com.example.tourismpackage.utils;

import com.example.tourismpackage.models.DestinationPackage;
import java.util.List;


public class PackageQuickSort {


    public static List<DestinationPackage> sortByPrice(List<DestinationPackage> packages) {
        if (packages == null || packages.size() <= 1) {
            return packages;
        }

        quickSort(packages, 0, packages.size() - 1);
        return packages;
    }


    public static List<DestinationPackage> sortByPriceDescending(List<DestinationPackage> packages) {
        if (packages == null || packages.size() <= 1) {
            return packages;
        }

        quickSortDescending(packages, 0, packages.size() - 1);
        return packages;
    }

    private static void quickSort(List<DestinationPackage> packages, int low, int high) {
        if (low < high) {
            int partitionIndex = partition(packages, low, high);

            // Recursively sort elements before and after partition
            quickSort(packages, low, partitionIndex - 1);
            quickSort(packages, partitionIndex + 1, high);
        }
    }

    private static void quickSortDescending(List<DestinationPackage> packages, int low, int high) {
        if (low < high) {
            int partitionIndex = partitionDescending(packages, low, high);

            // Recursively sort elements before and after partition
            quickSortDescending(packages, low, partitionIndex - 1);
            quickSortDescending(packages, partitionIndex + 1, high);
        }
    }

    private static int partition(List<DestinationPackage> packages, int low, int high) {
        // Choose the rightmost element as pivot
        double pivot = packages.get(high).getPrice();

        // Index of smaller element
        int i = low - 1;

        // Traverse through all elements
        for (int j = low; j < high; j++) {
            // If current element is smaller than or equal to pivot
            if (packages.get(j).getPrice() <= pivot) {
                i++;

                // Swap packages[i] and packages[j]
                DestinationPackage temp = packages.get(i);
                packages.set(i, packages.get(j));
                packages.set(j, temp);
            }
        }

        // Swap packages[i+1] and packages[high] (pivot)
        DestinationPackage temp = packages.get(i + 1);
        packages.set(i + 1, packages.get(high));
        packages.set(high, temp);

        return i + 1;
    }

    private static int partitionDescending(List<DestinationPackage> packages, int low, int high) {
        // Choose the rightmost element as pivot
        double pivot = packages.get(high).getPrice();

        // Index of smaller element
        int i = low - 1;

        // Traverse through all elements
        for (int j = low; j < high; j++) {
            // If current element is larger than or equal to pivot
            if (packages.get(j).getPrice() >= pivot) {
                i++;

                // Swap packages[i] and packages[j]
                DestinationPackage temp = packages.get(i);
                packages.set(i, packages.get(j));
                packages.set(j, temp);
            }
        }

        // Swap packages[i+1] and packages[high] (pivot)
        DestinationPackage temp = packages.get(i + 1);
        packages.set(i + 1, packages.get(high));
        packages.set(high, temp);

        return i + 1;
    }
}
